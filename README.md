# 🆘 Emergency Wallet

**A Flutter-based emergency savings wallet that nudges users to set money aside *before* a crisis hits — not scramble for it during one.**

> Status: 🚧 Active Development — Core authentication, onboarding, and dashboard simulator complete; Firestore integration in progress

---

## 🔗 Quick Links

- 📖 **[Developer Wiki](https://github.com/elsaramji/emergency_wallet/wiki)** — Comprehensive documentation on Clean Architecture, database schema, design system, and developer guidelines.
- 🌐 **[Interactive Overview & Simulator](https://elsaramji.github.io/emergency_wallet_overview-/)** — A web-based interactive project dashboard featuring the design system and an active screen simulator.

---

## 💡 The Problem

Most people don't have an emergency fund not because they can't save, but because there's no system pushing them to. Regular savings apps treat every goal the same way — a vacation fund and an emergency fund get identical treatment, with identical (easy) access. That ease of access is exactly why emergency funds get raided for non-emergencies and never recover.

## 🎯 The Solution

Emergency Wallet is purpose-built around one behavior: **friction on withdrawal, ease on deposit.**

- Users commit to a monthly savings target for their emergency fund
- Funds are protected by an **emergency lock mechanism** — withdrawals require an explicit "this is a real emergency" action, not a casual tap
- Monthly transaction buckets give users a clear, honest picture of what they've saved and when
- The product is designed to build a saving *habit*, not just store a balance

---

## ✨ Key Features

- 🔒 **Emergency Lock Logic** — a deliberate friction layer between "I want my money" and "I have my money," designed to prevent impulsive withdrawals while never blocking genuine emergencies
- 📅 **Monthly Transaction Buckets** — savings and spending are organized by month for clear tracking and historical visibility
- 🔥 **Firestore-Backed Data Layer** — real-time sync with a schema designed around dual-write batch patterns for data consistency across balance and transaction records
- 🌍 **Localization (l10n)** — built with multi-language support from day one
- 🎨 **Custom UI/UX** — complete user flow designed end-to-end (see `/ui_design`) before a single database call was written, reflecting a product-first build process
- 🔐 **Firestore Security Rules** — access rules defined explicitly (`firestore.rules`) rather than left on defaults
- 🖥️ **Interactive Overview Dashboard** — a web-based presentation of the project's architecture, design tokens, and a virtual phone simulator
- 📖 **Developer Wiki & Docs** — detailed guides on setup, styling tokens, localizations, and the database model

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart) |
| Backend / Data | Firebase — Firestore, Firestore Security Rules, Firestore Indexes |
| Architecture | Clean Architecture, SOLID principles |
| Localization | Flutter l10n |
| Platforms | Android, iOS |

---

## 🏗️ Architecture & Data Design

The data layer is intentionally designed around real-world financial-app constraints rather than a simple CRUD model:

- **Dual-write batch patterns** to keep a user's running balance and their transaction history atomically consistent — a balance update and its corresponding transaction record are written together or not at all
- **Monthly bucketing** of transactions for efficient querying and clear historical reporting, instead of one unbounded transaction collection per user
- **Explicit security rules** (`firestore.rules`) scoping read/write access per user, and composite indexes (`firestore.indexes.json`) to support the query patterns the app actually uses

```
lib/            → application source (Clean Architecture layers)
ui_design/      → UI/UX flow references and design assets
docs/           → project documentation
firestore.rules → Firestore access control
firestore.indexes.json → Firestore composite indexes
```

---

## 📱 Project Status / Roadmap

- [x] Full UI/UX and user flow design
- [x] Firestore security rules
- [x] Firestore composite indexes
- [x] Authentication & Onboarding integration
- [x] Interactive Dashboard Overview & Screen Simulator
- [x] Comprehensive Developer Wiki & Architectural Rules
- [ ] Firestore data schema — final implementation (in progress)
- [ ] Emergency lock/unlock flow — end-to-end wiring
- [ ] Monthly bucket aggregation logic
- [ ] Public release build

---

## 🚀 Getting Started

```bash
git clone https://github.com/elsaramji/emergency_wallet.git
cd emergency_wallet
flutter pub get
flutter run
```

> Requires a Firebase project connected via `flutterfire configure` (Firestore enabled) to run with live data.

---

## 👤 Author

**Mahmoud Ahmed Badawy**
Flutter Developer | Clean Architecture & SOLID | Fintech-focused
[LinkedIn](https://www.linkedin.com/in/mahmoud-el-seramji/) · [GitHub](https://github.com/elsaramji)

---

## 📄 License

This project is currently unlicensed / private-use during active development. License to be added at public release.
