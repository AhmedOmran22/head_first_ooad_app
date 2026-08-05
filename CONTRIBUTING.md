# Contributing to Head First OOA&D Companion App

Thanks for your interest in contributing! This document covers the basics for getting a change proposed and merged.

## Getting Started

1. **Fork** the repository on GitHub.
2. **Clone** your fork locally:
   ```bash
   git clone https://github.com/<your-username>/head_first_ooad_app.git
   cd head_first_ooad_app
   ```
3. Add the upstream repository as a remote so you can keep your fork in sync:
   ```bash
   git remote add upstream https://github.com/AhmedOmran22/head_first_ooad_app.git
   ```
4. Install dependencies:
   ```bash
   flutter pub get
   ```

## Branch Naming

Create a new branch off `main` for every change, using the format:

```
<type>/<short-description>
```

Where `<type>` is one of:

- `feature/` — new functionality (e.g. `feature/chapter-search`)
- `fix/` — bug fixes (e.g. `fix/tab-bar-overflow`)
- `chore/` — tooling, deps, CI, non-functional changes
- `docs/` — documentation-only changes
- `refactor/` — code changes that don't alter behavior

## Commit Message Format

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(optional scope): <short summary>

<optional longer description>
```

Examples:

```
feat(chapter_summary): add key-points tab bookmarking
fix(router): correct route for chapter deep links
docs: update README installation steps
```

Common types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`.

## Code Style & Linting

- The project uses [`flutter_lints`](https://pub.dev/packages/flutter_lints) via `analysis_options.yaml`. Run the analyzer before committing:
  ```bash
  flutter analyze
  ```
- Format code with:
  ```bash
  dart format .
  ```
- Follow the existing feature-first, Clean Architecture layering (`data` / `domain` / `presentation`) when adding new features — see the folder structure in [README.md](README.md).
- Keep widgets small and composable; prefer extracting reusable pieces into `presentation/widgets`.

## Pull Request Guidelines

- Keep PRs focused on a single change; avoid bundling unrelated fixes.
- Ensure `flutter analyze` and `flutter test` pass before opening a PR.
- Fill out a clear PR description: what changed and why.
- Link any related issues.
- Include screenshots or a short clip for UI changes.
- Be responsive to review feedback — small, iterative commits are easier to review than large rewrites.

## Reporting Issues

Please use GitHub Issues to report bugs or propose features. Include steps to reproduce, expected vs. actual behavior, and your Flutter/Dart version (`flutter --version`) where relevant.
