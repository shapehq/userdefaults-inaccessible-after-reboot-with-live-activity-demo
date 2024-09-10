# Prewarming Issue Demo App
The demo app helps demostrate an issue that we have found where an app that is showing a live activity, when restarting the phone, will get prewarmed when the phone is still locked causing all UserDefaults values to be null. Causing several different issues.

## How to reproduce
1. Open the app.
2. Finish the onboarding.
3. Start the live activity.
4. Turn the phone off.
5. Turn the phone back on, do not unlock.
6. Wait a couple of seconds, a minute at most.
7. Unlock and open the app.

If the bug did happen, you will notice that the onboarding is shown again. If you then quit and re-open the app, the onboarding will not be shown.

## Why
We have noticed that when a live activity is being shown, the OS will prewarm (launch) the app as soon as possible to, probably, update the live activity imidiatly after reboot, this causes the UserDefaults to be read, but since UserDefaults is protected until first unlock, everything will be read as null.
