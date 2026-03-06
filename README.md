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

## 🔑 Autenticación y Pruebas

Para facilitar las pruebas locales, la aplicación cuenta con un flujo de autenticación simulado y soporte para Firebase/Google Sign-In.

### 🧪 Credenciales de Prueba (Login Local)
Puedes ingresar a la aplicación utilizando las siguientes credenciales de prueba en el formulario de login:

*   **Email:** Debe contener `testDev` (Ejemplo: `testDev@catchall.com`)
*   **Password:** Debe contener `c4tch-All-App`

### 🔄 Flujo de Ingreso
1. Inicie la aplicación.
2. En la pantalla de Login, ingrese el correo y contraseña mencionados arriba.
3. Presione el botón de **Login**.
4. Si las credenciales son válidas, será redirigido a la pantalla principal (Home).

También puede utilizar el botón de **Google Sign-In** si la configuración de Firebase está activa en su entorno.

---

## 🛠 Git Workflow & Commits

To maintain code quality and consistency, please follow these steps before committing your changes:

1. **Analyze the code** (Do not commit if there are errors or warnings):
```bash
flutter analyze
```

2. **Add and Commit**:
```bash
git add .
git commit -m "feat: your descriptive message"
```

3. **Push changes**:
```bash
git push
```
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
