# Contributing to Tidyo 🧹

Thank you for your interest in contributing to **Tidyo**! Tidyo is a 100% free and open-source mobile cleaner built with Flutter.

## 🏛️ Code Architecture & Standards

1. **Feature-First Clean Architecture:**
   - Every feature is located in `lib/Features/<FeatureName>/` with strict separation of concerns:
     - `Domain/` (Entities, Repositories contracts, UseCases)
     - `Data/` (DataSources, Repositories implementations, Models)
     - `Presentation/` (Providers, Screens, Widgets)
2. **Modular Dependency Injection:**
   - Each feature registers its dependencies in `lib/Config/Injection/Modules/<FeatureName>Injection.dart`.
3. **PascalCase Naming:**
   - All directories and Dart files use strict PascalCase (e.g., `JunkScannerProvider.dart`, `FileSystemDataSource.dart`).
4. **Zero Ads, Zero Telemetry:**
   - Tidyo has strict zero-tracking policies. Never add advertising SDKs, non-consensual telemetry, or destructive deletion methods.

## 🛠️ Development Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Fardin7798/Tidyo.git
   cd Tidyo
   ```
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Run code analysis:**
   ```bash
   flutter analyze
   ```
4. **Run tests:**
   ```bash
   flutter test
   ```

## 🚀 Submitting Pull Requests

- Ensure `flutter analyze` reports zero issues (`No issues found!`).
- Ensure all tests pass (`flutter test`).
- Keep PRs focused on a single feature or bug fix.
