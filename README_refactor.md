# 🧠 Clean Architecture Refactor (Flutter Demo E-Commerce)

This branch demonstrates how the app was refactored to apply **Clean Architecture**, **SOLID principles**, and **Riverpod** state management.

lib/
├── core/ # constants, utilities
├── data/ # API & local data sources
├── domain/ # business logic, entities, use-cases
├── presentation/ # UI, providers, screens
└── injection/ # dependency injection (GetIt)

## 🏗️ Layers Overview

---

## 🧩 State Management – Riverpod
- Uses `FutureProvider` for async data loading.
- UI automatically reacts to data, error, and loading states.
- Replaces old `ChangeNotifier`-based Provider logic.

---

## 💉 Dependency Injection – GetIt
- Centralized singletons via `injection/dependency_injection.dart`.
- Services (like `ApiService`) are shared safely across layers.

---

## ⚡ Performance & SOLID
- Separation of concerns (no business logic in UI).
- Each class has a single responsibility.
- Extensible for new features (Favorites, Cart, Auth).

---

## 🧠 Next Work
- Add caching via `shared_preferences` or `hive`.
- Move login flow to Riverpod.
- Integrate `flutter_secure_storage` for secure tokens.
