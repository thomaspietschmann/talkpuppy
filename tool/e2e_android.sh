#!/usr/bin/env bash
# End-to-end tests of Talkpuppy's Android floating button on an emulator.
#
#   tool/e2e_android.sh [emulator-serial]
#
# Maestro (https://maestro.dev) drives the app and the system settings
# (.maestro/android); the floating button itself is driven over adb, since
# Maestro doesn't reliably see other apps' accessibility overlays. Its state
# is read from the service's log (tag TalkpuppyOverlay). Needs a running
# emulator; uses the debug APK (DebugInsertReceiver) and resets Talkpuppy's
# data on the emulator. The emulator's microphone records silence, so a
# dictation ends in "nothing recognized".
set -uo pipefail
export ANDROID_SERIAL="${1:-emulator-5554}"
ADB="${ANDROID_HOME:-$HOME/Library/Android/sdk}/platform-tools/adb"
MAESTRO="${MAESTRO:-$HOME/.maestro/bin/maestro}"
PKG=de.pietschie.talkpuppy
SERVICE=$PKG/$PKG.overlay.OverlayAccessibilityService
APK=build/app/outputs/flutter-apk/app-debug.apk
cd "$(dirname "$0")/.."

pass=0; fail=0; failed=()
ok() { echo "  ✓ $1"; pass=$((pass + 1)); }
ko() { echo "  ✗ $1"; fail=$((fail + 1)); failed+=("$1"); }
check() { if eval "$2"; then ok "$1"; else ko "$1"; fi; }

flow() {
  "$MAESTRO" --device "$ANDROID_SERIAL" test ".maestro/android/$1.yaml" >"/tmp/talkpuppy-e2e-$1.log" 2>&1
}
service_on() { $ADB shell settings put secure enabled_accessibility_services "$SERVICE"; }
service_off() { $ADB shell settings put secure enabled_accessibility_services '""'; }
home() { $ADB shell input keyevent KEYCODE_HOME; sleep 1.5; }
open_app() { $ADB shell monkey -p $PKG -c android.intent.category.LAUNCHER 1 >/dev/null 2>&1; sleep 3; }

# The floating button's window: "x y w h" (empty if there is none).
button_rect() {
  $ADB shell dumpsys window windows \
    | awk '/Window #[0-9]+ Window\{[0-9a-f]+ u0 de\.pietschie\.talkpuppy\}/{f=1} f&&/ty=ACCESSIBILITY_OVERLAY/{print; exit}' \
    | sed -nE 's/.*\{\(([0-9]+),([0-9]+)\)\(([0-9]+)x([0-9]+)\).*/\1 \2 \3 \4/p'
}
button_center() { button_rect | awk '{print int($1+$3/2), int($2+$4/2)}'; }
button_shown() {
  $ADB shell dumpsys window windows \
    | awk '/Window #[0-9]+ Window\{[0-9a-f]+ u0 de\.pietschie\.talkpuppy\}/{f=1} f&&/mViewVisibility/{print; exit}' \
    | grep -q "mViewVisibility=0x0"
}
tap_button() { local c; c=$(button_center); [ -n "$c" ] && $ADB shell input tap $c; }
log_mark() { $ADB logcat -c; }
# Waits until the service logged "state=$1" (since the last log_mark).
wait_state() {
  local deadline=$((SECONDS + ${2:-15}))
  while [ $SECONDS -lt $deadline ]; do
    $ADB logcat -d -s TalkpuppyOverlay | grep -qE "state=($1)" && return 0
    sleep 0.3
  done
  return 1
}
saw_state() { $ADB logcat -d -s TalkpuppyOverlay | grep -qE "state=($1)"; }
# Any result: silence gives NO_SPEECH, but Whisper sometimes makes up a word
# on silence, which then lands in the clipboard (COPIED) or a field.
RESULT="NO_SPEECH|COPIED|SUCCESS"
last_visibility() { $ADB logcat -d -s TalkpuppyOverlay | grep -o "visible=.*" | tail -1; }
crashed() { $ADB logcat -d | grep -A3 "FATAL EXCEPTION" | grep -q "$PKG"; }

# A dictation from tap to result; the emulator records silence.
dictate() {
  log_mark
  tap_button
  wait_state RECORDING 20 || return 1
  sleep 1
  tap_button
  wait_state "$RESULT" 30
}

[ -f "$APK" ] || flutter build apk --debug --target-platform android-arm64
$ADB install -r "$APK" >/dev/null
service_off
$ADB shell settings delete secure accessibility_button_targets >/dev/null 2>&1
# The full path asks for every permission again.
for p in RECORD_AUDIO POST_NOTIFICATIONS; do
  $ADB shell pm revoke $PKG android.permission.$p 2>/dev/null
  $ADB shell pm clear-permission-flags $PKG android.permission.$p user-set user-fixed 2>/dev/null
done

echo "▶ Setup: model, microphone, notifications, accessibility service, minimize"
log_mark
check "setup flow (Maestro)" 'flow 01_setup_full'
sleep 2
check "button appears after setup" 'button_shown'
check "button active over the launcher" '[[ "$(last_visibility)" == *"dimmed=false"* ]]'
r=$(button_rect); w=$($ADB shell wm size | grep -oE "[0-9]+x[0-9]+" | tail -1 | cut -dx -f1)
check "button keeps a gap to the screen edge ($r)" '[ -n "$r" ] && [ $(( $(echo $r | cut -d" " -f1) + $(echo $r | cut -d" " -f3) )) -lt "$w" ]'

echo "▶ Dictation"
check "tap → record → stop → result" 'dictate'
check "back to idle afterwards" 'wait_state IDLE 5'

echo "▶ Greyed out over the app"
log_mark; open_app
check "greyed out while the app is open" '[[ "$(last_visibility)" == *"dimmed=true"* ]]'
log_mark; tap_button; sleep 2
check "taps are ignored there" '! saw_state PREPARING'
log_mark; home
check "active again after leaving the app" '[[ "$(last_visibility)" == *"dimmed=false"* ]]'

echo "▶ Long press cancels a recording"
log_mark; tap_button
if wait_state RECORDING 20; then
  c=$(button_center); $ADB shell input swipe $c $c 1000; sleep 2
  check "long press → idle without result" 'wait_state IDLE 5 && ! saw_state "$RESULT"'
else ko "long press: recording didn't start"; fi

echo "▶ A second tap while starting doesn't cancel"
log_mark; c=$(button_center); $ADB shell "input tap $c; input tap $c"
check "still reaches recording" 'wait_state RECORDING 20'
tap_button; wait_state "$RESULT" 30 >/dev/null; wait_state IDLE 5 >/dev/null

echo "▶ Incoming call during a dictation"
log_mark; tap_button
if wait_state RECORDING 20; then
  $ADB emu gsm call 5551234 >/dev/null; sleep 4
  check "call ends the dictation with a result" 'wait_state "$RESULT" 30'
  $ADB emu gsm cancel 5551234 >/dev/null; sleep 2
else ko "call: recording didn't start"; fi
wait_state IDLE 5 >/dev/null

# Not covered: the notification's Stop action. The notification is posted
# (dumpsys notification shows it with the FGS flags), but this emulator's
# shade doesn't list it, so there's nothing to tap.

echo "▶ Insertion (debug hook, without microphone)"
$ADB shell am start -n com.google.android.settings.intelligence/.modules.search.SearchActivity >/dev/null 2>&1; sleep 3
log_mark
$ADB shell "am broadcast -n $PKG/.overlay.DebugInsertReceiver --es text 'Bluetooth'" >/dev/null; sleep 2
check "inserted into the focused field" '$ADB logcat -d -s TalkpuppyInsert | grep -q "outcome=INSERTED"'
$ADB shell uiautomator dump /sdcard/ui.xml >/dev/null 2>&1
check "field contains the text" '$ADB shell cat /sdcard/ui.xml | grep -q "text=\"Bluetooth\""'
home
log_mark
$ADB shell "am broadcast -n $PKG/.overlay.DebugInsertReceiver --es text 'Nirgends'" >/dev/null; sleep 2
check "no field → clipboard" '$ADB logcat -d -s TalkpuppyInsert | grep -q "outcome=COPIED"'

echo "▶ Shortcut hint"
$ADB shell settings put secure accessibility_button_targets "$SERVICE"
check "hint and link to the service page (Maestro)" 'flow 04_shortcut_hint'
$ADB shell settings delete secure accessibility_button_targets >/dev/null
home

echo "▶ App screen destroyed (swiped away)"
open_app; home
task=$($ADB shell dumpsys activity recents | grep -B2 "$PKG" | grep -oE "Recent #[0-9]+: Task\{[0-9a-f]+ #[0-9]+" | grep -oE "#[0-9]+$" | tr -d "#" | head -1)
[ -n "$task" ] && $ADB shell am stack remove "$task" >/dev/null 2>&1; sleep 3
check "app screen is gone" '[ "$($ADB shell dumpsys activity activities | grep -c "$PKG/.MainActivity")" = "0" ]'
check "dictation still works" 'dictate'

echo "▶ Process killed by the system"
pid=$($ADB shell pidof $PKG)
$ADB shell run-as $PKG kill -9 "$pid"
for _ in $(seq 1 30); do np=$($ADB shell pidof $PKG); [ -n "$np" ] && [ "$np" != "$pid" ] && break; sleep 1; done
sleep 3
check "service restarted" '[ -n "$np" ] && [ "$np" != "$pid" ]'
check "button back" 'button_shown'
check "dictation after a cold start" 'dictate'

echo "▶ Service toggled off/on quickly"
log_mark
for _ in 1 2 3 4 5; do service_off; service_on; done
sleep 4
check "no crash" '! crashed'
check "button back after toggling" 'button_shown'

echo "▶ Rotation"
# The launcher is locked to portrait; Chrome rotates.
$ADB shell am start -n com.android.chrome/com.google.android.apps.chrome.Main >/dev/null 2>&1; sleep 3
$ADB shell settings put system accelerometer_rotation 0
$ADB shell settings put system user_rotation 1; sleep 4
r=$(button_rect); ps=$($ADB shell wm size | grep -oE "[0-9]+x[0-9]+" | tail -1); lw=${ps#*x}; lh=${ps%x*}
read -r bx by bw bh <<<"$r"
check "display rotated" '$ADB shell dumpsys window displays | grep -q "mCurrentRotation=ROTATION_90"'
check "button fully on screen in landscape ($r in ${lw}x${lh})" '[ -n "$r" ] && [ $((bx + bw)) -le "$lw" ] && [ $((by + bh)) -le "$lh" ]'
$ADB shell settings put system user_rotation 0; sleep 3
home

echo "▶ Microphone permission revoked"
$ADB shell pm revoke $PKG android.permission.RECORD_AUDIO; sleep 3
service_off; service_on; sleep 3
log_mark; tap_button
check "error instead of silence" 'wait_state ERROR 5'
$ADB shell pm grant $PKG android.permission.RECORD_AUDIO
wait_state IDLE 5 >/dev/null

echo "▶ Close on the ✕"
log_mark; c=$(button_center); ws=$($ADB shell wm size | grep -oE "[0-9]+x[0-9]+" | tail -1)
wx=${ws%x*}; wy=${ws#*x}
$ADB shell input swipe $c $((wx / 2)) $((wy * 88 / 100)) 1500; sleep 2
check "button hidden" '[[ "$(last_visibility)" == *"visible=false"* ]]'
check "setting turned off" '$ADB shell run-as $PKG cat shared_prefs/FlutterSharedPreferences.xml | grep -q "overlayEnabled\" value=\"false"'

echo
echo "$pass passed, $fail failed"
for f in "${failed[@]}"; do echo "  - $f"; done
[ "$fail" -eq 0 ]
