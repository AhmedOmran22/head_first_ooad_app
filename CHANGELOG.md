# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-08-05

### Added

- Initial public release.
- Chapters list and chapter detail pages with overview, key points, and content tabs.
- Custom lightweight Markdown parser and renderer for chapter summaries.
- Local data source serving bundled chapter summaries (`assets/summaries/chapter1.md` – `chapter10.md`).
- Clean Architecture-inspired feature structure (`data` / `domain` / `presentation`) for the `chapter_summary` feature.
- `flutter_bloc` (Cubit) state management and `get_it` dependency injection.
- `go_router`-based navigation.
- Dark theme UI with loading skeletons and animated transitions.
