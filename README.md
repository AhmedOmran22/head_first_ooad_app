# Head First OOA&D — Companion App

A Flutter app that presents structured, navigable chapter summaries for the book **Head First Object-Oriented Analysis and Design**. Each chapter is rendered from a local Markdown file into an interactive view with an overview, key points, and content tabs — useful for reviewing OOAD concepts on the go.

## Screenshots

> _Add screenshots or a GIF of the app here._

| Chapters List | Chapter Detail |
| :---: | :---: |
| _placeholder_ | _placeholder_ |

## Tech Stack & Architecture

- **Framework:** Flutter (Dart SDK `^3.11.1`)
- **State management:** [flutter_bloc](https://pub.dev/packages/flutter_bloc) (Cubit)
- **Dependency injection:** [get_it](https://pub.dev/packages/get_it)
- **Routing:** [go_router](https://pub.dev/packages/go_router)
- **UI:** Material, [google_fonts](https://pub.dev/packages/google_fonts), [lucide_icons](https://pub.dev/packages/lucide_icons), [flutter_animate](https://pub.dev/packages/flutter_animate), [shimmer](https://pub.dev/packages/shimmer) loading skeletons
- **Content:** Chapter summaries are authored as Markdown files bundled as assets and parsed at runtime by a custom lightweight Markdown parser (`lib/core/markdown`) — no backend or network calls involved

The app follows a **Clean Architecture**-inspired, feature-first structure:

```
presentation  →  domain  →  data
   (UI, Cubit)   (entities,    (datasources,
                  use cases,    repository impl,
                  repository     models)
                  contracts)
```

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (compatible with Dart `^3.11.1`)
- A configured Android/iOS toolchain (Android Studio / Xcode) or a browser for web
- No API keys or backend services are required — see [`.env.example`](.env.example)

## Installation

```bash
# 1. Clone the repository
git clone https://github.com/AhmedOmran22/head_first_ooad_app.git
cd head_first_ooad_app

# 2. Install dependencies
flutter pub get

# 3. (Optional) copy the env template — no variables are required today,
#    but this is where future configuration would go
cp .env.example .env
```

## Running the Project

```bash
# List available devices
flutter devices

# Run in debug mode on a connected device/emulator
flutter run

# Run on a specific platform
flutter run -d chrome     # Web
flutter run -d windows    # Windows desktop
```

To generate app launcher icons (from `assets/images/app_icon.png`):

```bash
dart run flutter_launcher_icons
```

## Folder Structure

```
lib/
├── main.dart
├── core/
│   ├── di/
│   │   └── injector.dart              # get_it service locator setup
│   ├── markdown/                      # Custom Markdown parsing & rendering
│   │   ├── inline_text.dart
│   │   ├── markdown_block_view.dart
│   │   ├── markdown_models.dart
│   │   └── markdown_parser.dart
│   ├── router/
│   │   └── app_router.dart            # go_router route configuration
│   └── theme/
│       └── app_theme.dart
└── features/
    └── chapter_summary/
        ├── data/
        │   ├── datasources/
        │   │   └── chapter_local_datasource.dart
        │   ├── models/
        │   │   └── chapter_model.dart
        │   └── repositories/
        │       └── chapter_repository_impl.dart
        ├── domain/
        │   ├── entities/
        │   │   └── chapter.dart
        │   ├── repositories/
        │   │   └── chapter_repository.dart
        │   └── usecases/
        │       └── get_chapter.dart
        └── presentation/
            ├── cubit/
            │   ├── chapter_cubit.dart
            │   └── chapter_state.dart
            ├── pages/
            │   ├── chapter_page.dart
            │   └── chapters_list_page.dart
            └── widgets/                # Chapter UI building blocks
                (chapter_header, chapter_tab_bar, key_points_tab,
                 overview_tab, content_tab, code_block_widget, ...)

assets/
├── images/                             # App icon & artwork
└── summaries/                          # chapter1.md … chapter10.md
```

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for branch naming, commit message conventions, and PR guidelines before opening a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
