# Développement

## Prérequis

- Flutter stable
- Dart fourni avec Flutter
- Android Studio ou VS Code
- SDK Android et/ou Xcode selon la plateforme

## Première installation

Linux / macOS : chmod +x tool/bootstrap.sh puis ./tool/bootstrap.sh

Windows PowerShell : ./tool/bootstrap.ps1

Le bootstrap génère les dossiers natifs Android, iOS et Web, installe les dépendances, formate, analyse et teste le projet.

## Exécution

flutter run

## Qualité

dart format lib test
flutter analyze
flutter test
