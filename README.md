# catch_all_app

A scalable Flutter application built using **Clean Architecture** principles to ensure maintainability, testability, and separation of concerns.

---

## 🏗 Architecture

This project follows **Clean Architecture**, inspired by Robert C. Martin (Uncle Bob).

The codebase is organized into three main layers:

```
lib/
│
├── core/               # Shared utilities, constants, themes, errors
│
├── data/               # Data sources and repository implementations
│   ├── models/
│   ├── services/
│   └── repositories/
│
├── domain/             # Business logic (pure Dart)
│   ├── entities/
│   ├── repositories/
│   └── services/
│
└── ui/       # UI & State management
    ├── feature/
            ├── screens/
            ├── widgets/
            └── bloc/ (or cubit / blocs)
```

---

## 📚 Clean Architecture Layers

### 1️⃣ Presentation Layer

* UI components (Screens, Widgets)
* State management (BLoC / Cubit)
* Calls repositories from the domain layer
* Does NOT contain business logic

### 2️⃣ Domain Layer

* Entities (Enterprise business objects)
* Repository contracts (abstract classes)


This layer has **no dependency on Flutter**.

### 3️⃣ Data Layer

* Repository implementations
* Remote and local data sources
* DTO / Model mapping
* Converts raw data into domain entities

---

## 🔄 Dependency Rule

Dependencies always point inward:

```
Presentation → Domain ← Data
```

* The domain layer does not depend on any other layer.
* The data layer depends on domain.
* The presentation layer depends on domain.

---

## 🧪 Testing Strategy

* Unit tests for use cases
* Mock repositories for domain testing
* Widget tests for presentation
* Integration tests for full flows

---

## 📦 State Management

This project uses:

* flutter_bloc (or replace with your actual state manager)
* get_it for dependency injection
* freezed for immutable models

---

## 🚀 Getting Started

1. Clone the repository:

```bash
git clone https://github.com/oscardcd/catch_all_app.git
```

2. Install dependencies:

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

3. Run the project:

```bash
flutter run
```

---

## 🎯 Why Clean Architecture?

* Scalable for large applications
* Easy to test
* Clear separation of concerns
* Independent business logic
* Maintainable over time

---

## 👨‍💻 Author

Oscar Correa
Software Engineer | Flutter Developer
