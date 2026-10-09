# Architecture — AfriDelight

AfriDelight suit une architecture feature-first inspirée de la Clean Architecture.

## Couches

- domain : modèles métier et règles indépendantes de Flutter.
- data : repositories et sources de données simulées.
- application : Riverpod, contrôleurs et orchestration d’état.
- presentation : écrans et widgets Material 3.
- core : thème, navigation, services et composants transversaux.

## État

Riverpod isole le catalogue, le panier, les favoris et le suivi de commande. Le faux repository peut être remplacé par une API REST ou Firebase sans réécrire les vues.

## Navigation

go_router centralise les routes et les transitions. Une ShellRoute porte la barre de navigation principale.

## UI

Le design reprend la direction visuelle des maquettes fournies : orange chaud, surfaces blanches, cartes arrondies, typographie sombre et hiérarchie visuelle forte.

Developed  by Devmaes.
