# AfriDelight 🍲

Application mobile Flutter de commande et de suivi de livraison de plats africains, conçue à partir des interfaces AfriDelight fournies et structurée pour évoluer vers une API réelle.

> **Developed  by Devmaes**

## Aperçu

<p align="center">
  <img src="docs/screenshots/accueil.png" width="210" alt="Accueil AfriDelight">
  <img src="docs/screenshots/menu.png" width="210" alt="Menu AfriDelight">
  <img src="docs/screenshots/commande.png" width="210" alt="Détail produit AfriDelight">
  <img src="docs/screenshots/panier.png" width="210" alt="Panier AfriDelight">
</p>

Les quatre images ci-dessus sont les **maquettes de référence fournies pour AfriDelight** (accueil, menu, personnalisation d’une commande et panier),Le suivi de livraison est présenté  dans cette galerie. Les images culinaires de démonstration utilisées dans l’application sont chargées depuis le réseau afin de conserver un dépôt léger.

## Architecture & Tech Stack

- Flutter / Dart
- Material 3
- Riverpod pour la gestion d’état
- GoRouter pour la navigation
- Architecture feature-first inspirée de la Clean Architecture
- Repository simulé asynchrone, facilement remplaçable par REST/Firebase
- Shimmer pour les états de chargement
- Feedback sonore et haptique natif
- GitHub Actions pour format, analyse et tests

## Fonctionnalités

- Accueil conforme à la direction visuelle orange/blanc
- Recherche de plats
- Filtres par catégories
- Catalogue dynamique
- Détail produit avec accompagnements et quantité
- Ajout et modification du panier
- Code promo de démonstration : AFRI10
- Favoris
- Suivi de livraison simulé
- Profil
- Transitions animées et micro-interactions
- Architecture extensible pour une vraie API

## Installation

Prérequis : Flutter stable, Android Studio ou VS Code, SDK Android et/ou Xcode.

1. Cloner : git clone https://github.com/Devmaes/afridelight.git
2. Entrer dans le projet : cd afridelight
3. Générer le scaffolding natif : flutter create . --platforms=android,ios,web
4. Installer : flutter pub get
5. Vérifier : flutter analyze puis flutter test
6. Lancer : flutter run

Windows : ./tool/bootstrap.ps1

Linux/macOS : chmod +x tool/bootstrap.sh puis ./tool/bootstrap.sh

## Documentation

- Architecture : docs/ARCHITECTURE.md
- Développement : docs/DEVELOPMENT.md
- Déploiement Git : docs/GIT_DEPLOYMENT.md
- Rapport de livraison : docs/DELIVERY_REPORT.md
- Changelog : CHANGELOG.md

## Auteur

**Devmaes**

**Developed  by Devmaes**
