import Flutter
import UIKit
import UniformTypeIdentifiers

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

    // Model files (large, re-downloadable) and the private recording
    // history must never end up in iCloud backups. ModelManager and
    // HistoryStore call this for their directories.
    let backupChannel = FlutterMethodChannel(
      name: "talkpuppy/ios_backup",
      binaryMessenger: engineBridge.applicationRegistrar.messenger()
    )
    backupChannel.setMethodCallHandler { call, result in
      guard call.method == "excludeFromBackup",
        let args = call.arguments as? [String: Any],
        let path = args["path"] as? String
      else {
        result(FlutterMethodNotImplemented)
        return
      }

      var url = URL(fileURLWithPath: path)
      var resourceValues = URLResourceValues()
      resourceValues.isExcludedFromBackup = true
      do {
        try url.setResourceValues(resourceValues)
        // Read it back from disk: a silently unset flag would mean private
        // recordings end up in iCloud.
        url.removeAllCachedResourceValues()
        let check = try url.resourceValues(forKeys: [.isExcludedFromBackupKey])
        guard check.isExcludedFromBackup == true else {
          result(
            FlutterError(
              code: "EXCLUDE_NOT_APPLIED",
              message: "isExcludedFromBackup is not set on \(path)",
              details: nil
            )
          )
          return
        }
        result(nil)
      } catch {
        result(
          FlutterError(
            code: "EXCLUDE_FAILED",
            message: error.localizedDescription,
            details: nil
          )
        )
      }
    }

    // Used to pick a sane default model during onboarding.
    let deviceInfoChannel = FlutterMethodChannel(
      name: "talkpuppy/device_info",
      binaryMessenger: engineBridge.applicationRegistrar.messenger()
    )
    deviceInfoChannel.setMethodCallHandler { call, result in
      switch call.method {
      case "totalRamBytes":
        result(Int64(ProcessInfo.processInfo.physicalMemory))
      case "freeDiskBytes":
        // Checked before a model download. "Important usage" counts space
        // iOS would free up (purgeable caches) for a user-initiated task.
        let path = (call.arguments as? [String: Any])?["path"] as? String
          ?? NSHomeDirectory()
        do {
          let values = try URL(fileURLWithPath: path).resourceValues(
            forKeys: [.volumeAvailableCapacityForImportantUsageKey])
          if let bytes = values.volumeAvailableCapacityForImportantUsage {
            result(bytes)
          } else {
            result(nil)
          }
        } catch {
          result(
            FlutterError(
              code: "FREE_SPACE_FAILED",
              message: error.localizedDescription,
              details: nil
            )
          )
        }
      default:
        result(FlutterMethodNotImplemented)
      }
    }

    // Transcripts can be private: keep them off other devices (Universal
    // Clipboard / Handoff) by putting them on the pasteboard local-only.
    let clipboardChannel = FlutterMethodChannel(
      name: "talkpuppy/clipboard",
      binaryMessenger: engineBridge.applicationRegistrar.messenger()
    )
    clipboardChannel.setMethodCallHandler { call, result in
      guard call.method == "copySensitive",
        let args = call.arguments as? [String: Any],
        let text = args["text"] as? String
      else {
        result(FlutterMethodNotImplemented)
        return
      }
      UIPasteboard.general.setItems(
        [[UTType.plainText.identifier: text]],
        options: [.localOnly: true]
      )
      result(nil)
    }
  }
}
