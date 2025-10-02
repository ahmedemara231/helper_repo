# Makefile

clean:
	flutter clean && flutter pub get

run:
	flutter run

apk:
	flutter build apk

upgrade:
	flutter pub upgrade

handlePods:
	cd ios && pod install && pod update && cd ..

openXcode:
	open ios/Runner.xcworkspace

translations:
	dart run generate/strings/main.dart

buildReleaseIos:
	flutter build ios --config-only --release

buildIpa:
	flutter build ipa