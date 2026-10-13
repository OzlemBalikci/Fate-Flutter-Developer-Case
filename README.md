# fate_developer_case

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## CI

GitHub Actions workflow: [`.github/workflows/ci.yml`](.github/workflows/ci.yml)

On every push/PR to `develop` or `main` it runs:

- `flutter pub get` + `flutter gen-l10n`
- Copies `tool/ci/firebase_options.stub.dart` → `lib/firebase_options.dart` (real file is gitignored)
- `build_runner`, `dart format` check, `flutter analyze`, `flutter test`

Local Firebase config is still from `flutterfire configure` (not committed).
