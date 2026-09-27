# Talkpuppy

Offline speech-to-clipboard for Android and iOS: tap, speak, tap — the
transcript is already in the clipboard. Speech recognition runs fully on the
device (sherpa-onnx with Parakeet TDT v3 or Whisper models).

## Development

```bash
flutter pub get
flutter analyze
flutter test
```

## Releases

CI/CD runs on GitHub (`.github/workflows/`):

- **CI** on every push to `main`: analyze and tests
- **Release** on a `v*` tag: signed APKs (one per CPU architecture) attached
  to a GitHub Release

```bash
git tag v0.0.2 && git push origin v0.0.2
```

The version name comes from the tag; the versionCode is derived from it
(`major*10000 + minor*100 + patch`), so tags must keep increasing.

### Install with Obtainium

Add the app in [Obtainium](https://github.com/ImranR98/Obtainium) with the
URL `https://github.com/thomaspietschmann/talkpuppy`. It picks the APK that
matches the phone's architecture and offers updates for new releases. The
repository is private, so Obtainium needs a GitHub personal access token
(fine-grained, read access to this repo's *Contents*) under
Settings → GitHub.

### Android signing

Signed with `~/Keystores/talkpuppy-release.keystore` (alias and passwords in
`talkpuppy-release.properties` next to it — **keep a backup, a lost key means
reinstalling the app**). Locally `android/key.properties` (gitignored) is a
copy of that properties file; CI gets it through the secrets
`SIGNING_KEYSTORE_B64`, `SIGNING_STORE_PASSWORD`, `SIGNING_KEY_ALIAS`,
`SIGNING_KEY_PASSWORD`.

### iOS

Signed with a free personal Apple team (see `ios/Flutter/*.xcconfig`) and
installed directly from the Mac:

```bash
flutter build ios --release
xcrun devicectl device install app --device <udid> build/ios/iphoneos/Runner.app
```

Free-team builds stop launching after 7 days and need reinstalling.
