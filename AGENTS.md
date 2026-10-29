# AGENTS.md — Operational Guidelines for Tidyo

## 🎯 Architectural Principles & SSOT
- **Clean Architecture Standard:** Feature-First Reso Coder standard.
  - `lib/core/`: Cross-cutting concerns (Constants, Error envelopes, Result pattern, Platform & Storage Services).
  - `lib/features/<FeatureName>/domain/`: Pure Dart entities, usecases, and repository contracts (Zero external dependencies).
  - `lib/features/<FeatureName>/data/`: Models, data sources (FileSystem, RulesEngine), and repository implementations.
  - `lib/features/<FeatureName>/presentation/`: State notifiers, presentation models, screens, and UI widgets.
- **Naming Conventions:** Strict PascalCase for all Dart and Kotlin files (`FileName.dart`, `CleanerEngine.kt`).
- **Zero-Stub Policy:** Every method, use case, and repository must contain complete, functional logic. No placeholder functions or fake mock returns.

## 🛡️ Quarantine & Safety Imperatives
- **100% Safe Clean Targets:**
  - System logs (`.log`, `.crashlog`).
  - Temporary files (`.tmp`, `.temp`, `.cache`).
  - Generated thumbnails (`.thumbnails` directories).
  - Empty directories with zero files (excluding system root folders).
  - Leftover installer APKs (`.apk`) not situated in user Downloads.
- **Strictly Protected Quarantine (Never Touched):**
  - Camera directory (`DCIM/`).
  - User Documents (`Documents/`).
  - Personal Downloads (`Download/`).
  - WhatsApp personal media databases and sent attachments.

## 🧪 Verification & Evidence Contracts
- Static Analysis: `flutter analyze` must return 0 errors and 0 warnings.
- Execution Verification: All file I/O operations must be tested with live terminal commands and exit code 0.
- Linter Alignment: Enforce `file_names: false` in `analysis_options.yaml` to preserve PascalCase naming.
