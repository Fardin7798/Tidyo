# Tidyo 🧹✨

> **The 100% Free & Open-Source, Cross-Platform Mobile Cleaner for Android & iOS.**  
> Zero Ads. Zero Telemetry. 100% Genuine Storage Recovery.

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-3.47+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.13+-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-blue)](https://github.com/Fardin7798/Tidyo)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/Fardin7798/Tidyo/pulls)

---

## 🌟 Why Tidyo?

Most mobile cleaner apps on app stores are filled with invasive fullscreen ads, sketchy background telemetry, and fake "boosting" animations that actually consume more RAM and battery than they save.

**Tidyo is built differently:**
- **100% Free & Open-Source:** Fully auditable code. No hidden backdoors, no user tracking.
- **Genuine Storage Engine:** Directly interfaces with real filesystem partitions (`StatFs`, POSIX directory streams). No simulated numbers.
- **Safe 3-Tier Quarantine:** Protects user documents, downloads, and camera photos from accidental deletion.
- **Zero Asset Bloat:** Built with custom vector renderers (`CustomPainter`) for sub-millisecond launch times and tiny APK footprint.
- **Cross-Platform Vision:** Engineered in Flutter for seamless execution across Android and iOS devices.

---

## 📱 Core Features

### 1. Real-Time Storage Dashboard
- Live storage progress ring tracking device partition metrics (`Used`, `Free`, `Total`).
- Instant health evaluation and one-tap safe junk scanning.

### 2. Intelligent Junk Scanner
- Live recursive directory scanner with real-time file counters and path breadcrumbs.
- Detects app cache, orphan `.tmp` files, obsolete logs, and stale APK installers.

### 3. Safe 3-Tier Results Quarantine
- **100% Safe:** Empty folders, app logs, temporary cache, old APK installers (auto-checked).
- **Review Required:** WhatsApp stickers, voice notes, screenshots (requires explicit user confirmation).
- **Protected:** Camera photos, downloads, system documents (permanently locked).

### 4. Deep Clean (Messaging & Social Cache)
- Dedicated WhatsApp cleaner for sent media, status cache, voice notes, and stickers.
- Telegram and web browser cache managers.

### 5. Storage Analyzer & Big Files Hunter
- Storage composition breakdown (Photos, Videos, Apps, Junk).
- Big Files Hunter with custom threshold filters (`25 MB+`, `50 MB+`, `100 MB+`).
- SHA-256 Duplicate Finder pipeline.

---

## 🛠️ Architecture

Tidyo follows **Feature-First Clean Architecture**:

```
lib/
├── Core/
│   ├── Models/         # Storage and junk data representations
│   ├── Services/       # Filesystem scanner & storage partition APIs
│   ├── Theme/          # FigCraft design tokens (Tk)
│   └── Widgets/        # Custom SVG path painters & 360 canvas
└── Features/
    ├── Dashboard/      # Main storage telemetry screen
    ├── JunkScanner/    # Scanning & results presentation
    ├── DeepClean/      # WhatsApp, Telegram, Browser cleanup
    ├── StorageAnalyzer/# Big files hunter & space diagnostics
    └── Shell/          # Main bottom navigation & app state coordinator
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `^3.47.5`
- Dart SDK `^3.13.4`
- Android Studio / VS Code with Flutter extension
- JDK 17 (Temurin 17 recommended)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Fardin7798/Tidyo.git
   cd Tidyo
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run on connected device / emulator:**
   ```bash
   flutter run
   ```

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request or open an issue for bug reports and feature requests.

---

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.
