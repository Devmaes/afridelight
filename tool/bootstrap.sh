#!/usr/bin/env bash
set -euo pipefail
flutter create . --platforms=android,ios,web
flutter pub get
dart format lib test
flutter analyze
flutter test
echo "AfriDelight is ready."
