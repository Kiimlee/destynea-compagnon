# Destynéa Compagnon

App iOS compagnon pour **Destynéa**, mon propre système de jeu de rôle en d100.
Objectif : aider joueurs et maître du jeu pendant une partie (jets de dés, pièces de karma, bestiaire).

Le projet me sert aussi de terrain d'entraînement : **Swift 6 en concurrence stricte**, **Clean Architecture** et **TDD**. Chaque fonctionnalité commence par un test.

> 🚧 En cours : le cœur métier et le bestiaire sont testés. L'écran SwiftUI du bestiaire est en développement.

## Stack

- Swift 6 (`swiftLanguageModes: [.v6]`, concurrence stricte), iOS 17+ / macOS 14+
- Swift Package Manager (package `DestyneaCore`)
- Swift Testing : 53 tests (paramétrés, asynchrones, stubs, fixtures)
- `@Observable`, `@MainActor`, `Sendable`, `async/await`
- Aucune dépendance externe

## Architecture

```
DestyneaCore/Sources/DestyneaCore
├── Check, D100, Dice, KarmaCoin, KarmaPurse   → règles du jeu (pures, sans I/O)
└── Bestiary
    ├── Domain        Creature, CreatureRepository (protocole), FetchBestiaryUseCase
    ├── Data          CreatureDTO, mapping DTO → Domain, JSONCreatureRepository
    └── Presentation  BestiaryViewModel (@MainActor, @Observable)
```

- **Domain** ne dépend de rien : entités, protocole de repository, use case.
- **Data** implémente le protocole et convertit les DTO en entités du domaine.
- **Presentation** expose un état (`loading` / `loaded` / `empty` / `failed`) à la vue.
- Les dépendances sont **injectées par protocole** (`Dice`, `CreatureRepository`). On peut ainsi remplacer le hasard ou les données par des doubles de test.

## Quelques choix techniques

- **Hasard testable** : un jet de dé passe par un protocole `Dice`. En test, un `LoadedDice` renvoie la valeur voulue.
- **Valeurs invalides impossibles** : `D100` n'accepte que les valeurs de 1 à 100 (init faillible).
- **Décodage JSON tolérant** : une créature mal formée est ignorée sans invalider tout le bestiaire. Un rang inconnu écarte la créature. Une origine ou une taille inconnue devient `nil`. Une fourchette illisible (ex. `"6-4"`) prend la valeur par défaut du rang.
- **Tri localisé** : les créatures sont triées par rang, puis par nom avec `localizedStandardCompare`, ce qui gère correctement les accents français.
- **Rafraîchissement sans perte** : si un pull-to-refresh échoue, la liste déjà affichée est conservée.
- **Concurrence** : le repository est `Sendable`, et le ViewModel est isolé sur le `MainActor`. Un double de test (`SequenceCreatureRepository`) est un `actor`.

## Lancer les tests

Avec Xcode : ouvrir `DestyneaCore/Package.swift`, puis lancer les tests avec ⌘U.

En ligne de commande (Swift Testing nécessite la toolchain de Xcode, pas seulement les Command Line Tools) :

```bash
cd DestyneaCore
swift test
```

## Workflow

Développement en TDD (rouge → vert → refactor), avec un commit par étape et des messages en [Conventional Commits](https://www.conventionalcommits.org/) (`feat`, `test`, `refactor`).

## Feuille de route

- [x] Jets de d100 : succès, échec, critiques
- [x] Pièces de karma : gain sur un échec, bourse limitée, dépense tout-ou-rien
- [x] Bestiaire : domaine, chargement JSON, ViewModel
- [ ] Écran SwiftUI du bestiaire (chargement, vide, erreur, pull-to-refresh, accessibilité VoiceOver)
- [ ] App iOS qui intègre le package
