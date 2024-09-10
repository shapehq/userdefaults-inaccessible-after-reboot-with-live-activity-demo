# Prewarming Issue Demo App

The demo app demonstrates an issue we’ve found where an app displaying a live activity, when restarting the phone, gets prewarmed while the phone is still locked, causing all UserDefaults values to be null and leading to several issues.

## How to Reproduce

1. Open the app.
2. Complete the onboarding.
3. Start the live activity.
4. Turn the phone off.
5. Turn the phone back on, but do not unlock it.
6. Wait a few seconds, or up to a minute.
7. Unlock and open the app.

If the bug occurs, you’ll notice that the onboarding is shown again. If you then quit and reopen the app, the onboarding will not appear.

## Why

We’ve noticed that when a live activity is being shown, the OS prewarms (launches) the app as soon as possible, likely to update the live activity immediately after reboot. This causes the app to attempt to read UserDefaults, but since UserDefaults is protected until the first unlock, all values are read as null.
