# CONTEXT.md — Project State & Architecture Execution (SSOT)

## Project Identity
- **Project Name:** Tidyo
- **Package ID:** `com.tidyo`
- **Platform:** Android (API 26 to 34+) via Flutter 3.47+ (Dart 3.13+)
- **Architecture Pattern:** Feature-First Clean Architecture (Reso Coder & Islamic Legacy Standard)
- **File Naming Standard:** Strict PascalCase (`FileName.dart`) with `file_names: false` linter override
- **Design Philosophy:** 100% Genuine Storage Recovery, Zero-Bloat, Zero-Ads, Safe 3-Tier Data Quarantine

## Current State
- **Project Scaffolding:** Initialized Flutter project under `/media/shaikhfardin/Data/Projects/Android Mobile/Tidyo`.
- **Linter Standardization:** `analysis_options.yaml` updated with `file_names: false` to enforce PascalCase compliance.
- **Android Manifest & Permissions:** Declared `MANAGE_EXTERNAL_STORAGE`, `PACKAGE_USAGE_STATS`, `QUERY_ALL_PACKAGES`, `READ_EXTERNAL_STORAGE`, and `WRITE_EXTERNAL_STORAGE` in `android/app/src/main/AndroidManifest.xml`.
- **Core Foundation Established (`lib/core/`):**
  - `constants/AppConstants.dart`: App colors, strings, storage thresholds, and channel identifiers.
  - `error/Failures.dart` & `error/AppExceptions.dart`: Domain failure envelopes and platform exceptions.
  - `result/Result.dart`: Functional Result pattern (`Success<T>` and `Error<T>`).
  - `usecase/BaseUseCase.dart`: Abstract use case contract.
  - `services/PermissionService.dart`: All-Files Access runtime verification and intent dispatcher.
  - `services/StorageService.dart`: Storage partition scanner via `StatFs` and directory telemetry.
- **Research Dossier:** Generated and verified 6-Sphere Research Dossier at `~/agent-reach/Downloads/Research Engine/Tidyo_Production_Architecture_Dossier.docx`.

## Phased Build Checklist
- [x] **Phase 1: Project Scaffolding & Setup**
  - Flutter Android scaffold in `Tidyo/`.
  - Configured PascalCase in `analysis_options.yaml`.
- [x] **Phase 2: Android Native Permissions & Manifest Alignment**
  - Scoped storage & all-files access declarations.
- [x] **Phase 3: Core Foundation Setup (`lib/core/`)**
  - Result pattern, BaseUseCase, Failures, Exceptions, Constants, PermissionService, StorageService.
- [x] **Phase 4: SSOT Documentation Alignment (`CONTEXT.md`, `AGENTS.md`)**
  - Cleaned stale drafts; synchronized unified architectural guidelines.
- [x] **Phase 5: Domain Layer Implementation (`features/JunkCleaner/Domain/`)**
  - Entities: `JunkItemEntity.dart`, `JunkCategoryEntity.dart`, `StorageStatsEntity.dart`.
  - Repository Contract: `JunkCleanerRepository.dart`.
  - Use Cases: `GetStorageStatsUseCase.dart`, `ScanJunkUseCase.dart`, `DeleteJunkUseCase.dart`.
- [x] **Phase 6: Data Layer Implementation (`features/JunkCleaner/Data/`)**
  - Models: `JunkItemModel.dart`, `JunkCategoryModel.dart`, `StorageStatsModel.dart`.
  - Data Sources: `FileSystemDataSource.dart`, `RulesDataSource.dart`.
  - Repository Impl: `JunkCleanerRepositoryImpl.dart`.
- [ ] **Phase 7: Rules Engine Database (`assets/rules/JunkRules.json`)**
  - Signatures for known cache, temp, thumbnail, and empty folder patterns.
- [x] **Phase 8: Presentation State Management (`features/JunkCleaner/Presentation/Controllers/`)**
  - `CleanerNotifier.dart` / `DashboardNotifier.dart` state management.
- [x] **Phase 9: Frontend UI Integration - [ ] **Phase 9: Frontend UI Integration & User Handoff User Handoff**
  - Connecting user-supplied Flutter presentation widgets to use cases and notifiers.
- [x] **Phase 10: Live Device Verification - [ ] **Phase 10: Live Device Verification & Testing** Testing**
  - Execution on connected Infinix X6711 device with zero errors (`flutter analyze`, exit code 0).
