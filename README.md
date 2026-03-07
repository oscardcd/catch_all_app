# catch_all_app

A scalable Flutter application built using **Clean Architecture** principles to ensure maintainability, testability, and separation of concerns.

---
## Description

This is a Flutter application that implements the Clean Architecture pattern to separate concerns and make the codebase more maintainable and testable.
use pokemon api to get pokemon list and details and show them for known pokemon.

updateds comming soon!!

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

## 🌐 Estrategia Offline
La aplicación implementa una estrategia de persistencia local robusta:
- **Caché de Datos**: Se utiliza un paquete de almacenamiento local (basado en Hive) para guardar la lista de Pokémon y sus detalles tras la primera consulta exitosa.
- **Soporte Offline**: Al iniciar la aplicación o navegar, el sistema verifica primero la existencia de datos locales. Si se detecta un fallo en la red o un error en la API, la app carga automáticamente los Pokémon guardados previamente.
- **Sincronización Silenciosa**: Cada vez que el usuario carga nuevos Pokémon desde la API, estos se agregan de forma incremental al almacenamiento local.

## 🔐 Flujo de Autenticación
El sistema de acceso está diseñado en capas:
1. **Presentación**: `LoginBloc` gestiona los eventos de entrada (Username/Password, Google, Firebase) y los estados de carga, éxito o fallo.
2. **Navegación**: Se utiliza `GoRouter` con lógica de redirección (`redirect`) que detecta automáticamente si el usuario tiene una sesión activa para enviarlo al Home o al Login.
3. **Persistencia de Sesión**: Los datos del usuario (nombre, ID) se mantienen de forma persistente para evitar re-autenticaciones innecesarias.

## 🌐 Internacionalización (i18n)
La aplicación cuenta con soporte multi-idioma utilizando el paquete **[slang](https://pub.dev/packages/slang)**. 

### 🚀 Cómo funciona
- **Configuración**: Los archivos de traducción se encuentran en `lib/i18n/` en formato JSON (`strings_en.i18n.json` y `strings_es.i18n.json`).
- **Generación de Código**: Al modificar las traducciones, es necesario regenerar el código tipado:
  ```bash
  flutter pub run build_runner build --delete-conflicting-outputs
  ```
- **Uso en Código**: Se utiliza la variable global `t` (o `context.t` para reactividad) para acceder a los textos:
  ```dart
  Text(t.home.welcome(name: 'Ash'))
  ```
- **Idiomas Soportados**: Actualmente incluye **Inglés (en)** y **Español (es)**. El sistema detecta automáticamente el idioma del dispositivo al iniciar.

## 🛠 Decisiones Técnicas
- **PokeAPI (API Externa)**: Seleccionada por ser el estándar de la industria para este tipo de aplicaciones, ofreciendo una estructura de datos rica ideal para demostrar Clean Architecture.
- **Hive (Persistencia Local)**: Se eligió por su alto rendimiento, facilidad de implementación sin esquemas complejos de SQL y soporte nativo para almacenamiento NoSQL.
- **BLoC/Cubit (Gestión de Estados)**: Elegido por su predictibilidad y clara separación de la lógica de negocio, lo que facilita las pruebas unitarias y la escalabilidad del proyecto.

## 🔮 Posibles Mejoras Futuras
- [ ] **Reglas de Negocio**: agregar reglas para hacer interactiva la app.
- [ ] **Paginación Optimizada**: Mejorar el control de carga infinita para evitar saltos en el scroll.
- [ ] **Cobertura de Tests**: Alcanzar un 90%+ de cobertura de pruebas unitarias y de integración.
- [x] **i18n**: Soporte para múltiples idiomas (Español, Inglés).
- [ ] **UI/UX Premium**: Implementar Shimmer effects avanzados y animaciones Hero fluidas para todas las imágenes.
- [ ] **Búsqueda y Filtros**: Añadir capacidad de búsqueda por nombre e ID y filtrado por tipo de Pokémon.

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
