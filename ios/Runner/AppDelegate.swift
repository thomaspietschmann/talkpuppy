import Flutter
import UIKit

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

    // Downloaded model files can be large (hundreds of MB) and are easily
    // re-downloaded, so they shouldn't count against the user's iCloud
    // backup quota. ModelManager calls this after a model finishes
    // downloading.
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
      if call.method == "totalRamBytes" {
        result(Int64(ProcessInfo.processInfo.physicalMemory))
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
  }
}
