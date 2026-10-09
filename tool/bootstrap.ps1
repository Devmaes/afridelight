$ErrorActionPreference = "Stop"
flutter create . --platforms=android,ios,web
flutter pub get
dart format lib test
flutter analyze
flutter test
Write-Host "AfriDelight is ready."
