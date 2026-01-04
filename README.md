# intelliprove-web-plugin-flutter

# Installation
## Prerequisites
- You have Android 16.0 "Baklava" (API Level 36.1) installed
- You have Android Build Tools and Command-line tools installed
- You have Xcode updated to 26.1

## Install Flutter
Install Flutter as described here:
https://docs.flutter.dev/install/with-vs-code

Run `flutter doctor -v` to verify the installation.

## Extra:
### Force Flutter version
Force the Flutter version to 3.35.7 so that we are all on the same Flutter version and can use the same Android and iOS SDKs.

- Find the `flutter` dir with `which flutter`.
- Go to the dir and checkout version 3.35.7 `git checkout 3.35.7`.
- Download the SDK by running `flutter doctor`.

### Accept Android SDK licenses
Run `flutter doctor --android-licenses`.

# Development
## Initialise the project
- Install the dependencies with `flutter pub get`.
- Clean the build folder with `flutter clean`. (optional)
- Re-add ios and android platforms with `flutter create --platforms=ios,android .`.

### ios
- Go to _ios_ folder
- Recreate the Podfile with `pod init`.
- Install the pods with `pod install`.

> If you don't have `pod` yet, install it with `brew install cocoapods`.

# Deploy on device
## ios
First time only:
- Open _Runner.xcworkspace_ in XCode with `xed ./ios/Runner.xcworkspace`.
- Make sure a 'Development Team' is selected under Signing & Capabilities > Team.


- Run the app with `flutter run lib/main.dart`