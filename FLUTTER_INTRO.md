# Introduction to Flutter

This guide explains what Flutter is, how it works under the hood, and the core ideas you need before writing real apps. It's a companion to the hands-on `README.md` guide.

---

## Table of Contents

1. [What is Flutter?](#1-what-is-flutter)
2. [Why Flutter?](#2-why-flutter)
3. [How Flutter Works](#3-how-flutter-works)
4. [Flutter vs Other Options](#4-flutter-vs-other-options)
5. [Core Concepts](#5-core-concepts)
6. [Anatomy of a Flutter App](#6-anatomy-of-a-flutter-app)
7. [The Widget Lifecycle](#7-the-widget-lifecycle)
8. [BuildContext Explained](#8-buildcontext-explained)
9. [Theming Basics](#9-theming-basics)
10. [Responsive Design Basics](#10-responsive-design-basics)
11. [Build Modes](#11-build-modes)
12. [Pros & Cons](#12-pros--cons)
13. [Glossary](#13-glossary)
14. [What to Learn Next](#14-what-to-learn-next)

---

## 1. What is Flutter?

**Flutter** is an open-source UI toolkit by **Google** for building apps from **one codebase** that run on:

| Platform | Output |
|----------|--------|
| 📱 Android | Native ARM app (APK / AAB) |
| 🍎 iOS | Native ARM app (IPA) |
| 🌐 Web | HTML/CSS/JS or WebAssembly |
| 💻 Windows / macOS / Linux | Native desktop app |
| 🔌 Embedded | Car dashboards, kiosks, smart devices |

- Language: **Dart** (also by Google)
- First stable release: **Flutter 1.0, December 2018**
- License: BSD (free, open source)

**One sentence:** you describe your UI with widgets in Dart, and Flutter draws every pixel itself on each platform.

---

## 2. Why Flutter?

- **One codebase, many platforms** → less code, smaller teams, faster delivery.
- **Hot reload** → see changes in under a second without restarting the app.
- **Consistent UI** → looks the same on every device because Flutter draws its own UI.
- **Fast performance** → compiled to native machine code (no JavaScript bridge).
- **Rich widget library** → Material (Android style) and Cupertino (iOS style) built in.
- **Huge package ecosystem** → thousands of packages on [pub.dev](https://pub.dev).

**Great for:** business apps, CRMs/HRMs, e-commerce, dashboards, MVPs, internal tools, apps with custom branded UI.

---

## 3. How Flutter Works

### The architecture (layers)

```
┌─────────────────────────────────────────────┐
│  YOUR APP (Dart code)                       │
├─────────────────────────────────────────────┤
│  FRAMEWORK (Dart)                           │
│  Material / Cupertino  ← ready-made widgets │
│  Widgets               ← building blocks    │
│  Rendering             ← layout & painting  │
│  Animation / Gestures / Painting            │
├─────────────────────────────────────────────┤
│  ENGINE (C++)                               │
│  Impeller / Skia  ← graphics rendering      │
│  Dart runtime, text layout, platform I/O    │
├─────────────────────────────────────────────┤
│  EMBEDDER (platform-specific)               │
│  Android / iOS / Web / Windows / macOS ...  │
└─────────────────────────────────────────────┘
```

### The key difference

Most frameworks ask the OS to draw native buttons, text, etc.
**Flutter draws everything itself** onto a canvas, like a game engine.

```
Other frameworks:   Your code → bridge → OS native button
Flutter:            Your code → Flutter engine → pixels on screen
```

That's why a Flutter app looks identical on Android 10 and Android 15, and why it's fast.

### The three trees

When you write widgets, Flutter internally maintains three trees:

| Tree | What it is | Cost |
|------|-----------|------|
| **Widget tree** | Your code — a lightweight *description* of the UI | Cheap, rebuilt often |
| **Element tree** | Links widgets to what's on screen, keeps state | Reused |
| **RenderObject tree** | Does the actual layout & painting | Expensive, updated only when needed |

This is why calling `build()` many times is fine: widgets are just cheap blueprints, and Flutter only repaints what actually changed.

---

## 4. Flutter vs Other Options

| | **Flutter** | **React Native** | **Native (Kotlin / Swift)** |
|---|---|---|---|
| Language | Dart | JavaScript / TypeScript | Kotlin / Swift |
| Codebases | 1 | 1 | 2 (one per platform) |
| UI rendering | Own engine | Native components | Native components |
| Performance | Near-native | Good | Best |
| UI consistency | Identical everywhere | Varies by platform | Platform-specific |
| Hot reload | ✅ | ✅ | Limited |
| Web / Desktop | ✅ Official | Partial (community) | ❌ |
| Learning curve | Easy–Medium | Easy if you know React | Two languages to learn |

**Rule of thumb:**
- Need one app on many platforms fast → **Flutter**
- Team already strong in React/JS → **React Native**
- Heavy platform-specific features (AR, advanced OS integration) → **Native**

---

## 5. Core Concepts

### 5.1 Everything is a widget

Text, buttons, padding, alignment, even the whole app — all widgets.

```dart
Padding(                          // widget
  padding: const EdgeInsets.all(16),
  child: Center(                  // widget
    child: Text('Hello'),         // widget
  ),
)
```

### 5.2 Composition over inheritance

You don't extend `Button` to make a custom button. You **combine** small widgets:

```dart
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const PrimaryButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}

// Usage
PrimaryButton(label: 'Save', onTap: () => print('Saved'));
```

### 5.3 Declarative UI

You describe **what** the UI should look like for the current state — not **how** to change it.

```dart
// Imperative (old way, NOT Flutter):
// label.setText("Logged in");
// button.hide();

// Declarative (Flutter):
Widget build(BuildContext context) {
  return isLoggedIn
      ? const Text('Welcome back!')
      : ElevatedButton(onPressed: login, child: const Text('Login'));
}
```

**UI = f(state)** → change the state, Flutter rebuilds the UI.

### 5.4 State

- **Ephemeral (local) state** → belongs to one widget (a toggle, a tab index). Use `setState`.
- **App state** → shared across screens (logged-in user, cart). Use Provider, Riverpod, Bloc, etc.

### 5.5 Constraints go down, sizes go up, parent sets position

The single most important layout rule:

```
Parent → tells child: "you can be between 0–400px wide"   (constraints DOWN)
Child  → answers:    "I'll be 200px wide"                 (size UP)
Parent → decides:    "I'll place you at x=100"            (position)
```

A widget **cannot** decide its own position, and can only choose a size **within** the constraints its parent gives. Most layout errors come from forgetting this.

---

## 6. Anatomy of a Flutter App

### Project files

```
my_app/
├── lib/
│   └── main.dart           ← entry point
├── assets/                 ← images, fonts, json (you create this)
├── test/                   ← unit & widget tests
├── android/                ← Android host project
├── ios/                    ← iOS host project
├── web/  windows/  macos/  linux/
├── pubspec.yaml            ← name, version, dependencies, assets
├── pubspec.lock            ← locked dependency versions
└── analysis_options.yaml   ← lint rules
```

### `pubspec.yaml`

```yaml
name: my_app
description: My first Flutter app
version: 1.0.0+1          # versionName+buildNumber

environment:
  sdk: ^3.5.0

dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0

flutter:
  uses-material-design: true
  assets:
    - assets/images/
```

### Suggested folder structure (as your app grows)

```
lib/
├── main.dart
├── app.dart                 # MaterialApp, theme, routes
├── core/                    # constants, utils, theme
├── models/                  # data classes (User, Product)
├── services/                # API, storage
├── providers/               # state management
├── screens/                 # full pages
│   ├── home/
│   └── login/
└── widgets/                 # reusable UI pieces
```

### Minimal app, explained line by line

```dart
import 'package:flutter/material.dart';   // Material widgets

void main() {                              // Dart entry point
  runApp(const MyApp());                   // attach root widget to the screen
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {     // describes the UI
    return MaterialApp(                    // app config: theme, navigation
      home: Scaffold(                      // page structure
        appBar: AppBar(title: const Text('Intro')),
        body: const Center(child: Text('Hello Flutter')),
      ),
    );
  }
}
```

---

## 7. The Widget Lifecycle

`StatefulWidget` has a lifecycle you'll use constantly:

```
createState()
     ↓
initState()              ← run once: init controllers, start API calls, listeners
     ↓
didChangeDependencies()  ← when inherited data (Theme, Provider) changes
     ↓
build()                  ← runs many times — keep it fast & side-effect free
     ↓
didUpdateWidget()        ← parent rebuilt with new parameters
     ↓
setState() → build() again
     ↓
dispose()                ← run once: clean up controllers, streams, timers
```

```dart
import 'dart:async';
import 'package:flutter/material.dart';

class ClockWidget extends StatefulWidget {
  const ClockWidget({super.key});

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  late Timer _timer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer.cancel();       // prevent leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = '${_now.hour.toString().padLeft(2, '0')}:'
        '${_now.minute.toString().padLeft(2, '0')}:'
        '${_now.second.toString().padLeft(2, '0')}';
    return Text(t, style: const TextStyle(fontSize: 40));
  }
}
```

**App lifecycle** (foreground / background) is separate:

```dart
class _MyPageState extends State<MyPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // resumed, inactive, paused, hidden, detached
    debugPrint('App state: $state');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => const Placeholder();
}
```

---

## 8. BuildContext Explained

`BuildContext` = **the widget's location in the tree**. It lets a widget look *up* the tree to find things.

```dart
Theme.of(context)                  // nearest theme
MediaQuery.sizeOf(context)         // screen size
Navigator.of(context)              // nearest navigator
ScaffoldMessenger.of(context)      // show snackbars
context.read<CartModel>()          // Provider
```

**Common trap:** the `context` from `build()` is *above* the `Scaffold` you create in that same method, so `Scaffold.of(context)` fails. Fix with a `Builder`:

```dart
Scaffold(
  body: Builder(
    builder: (innerContext) => ElevatedButton(
      onPressed: () => Scaffold.of(innerContext).openDrawer(),
      child: const Text('Open drawer'),
    ),
  ),
  drawer: const Drawer(),
)
```

---

## 9. Theming Basics

Define styles once, use everywhere.

```dart
MaterialApp(
  theme: ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
  darkTheme: ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.teal,
      brightness: Brightness.dark,
    ),
  ),
  themeMode: ThemeMode.system,  // follow device light/dark
  home: const HomePage(),
);

// Using it in a widget
final colors = Theme.of(context).colorScheme;
final text = Theme.of(context).textTheme;

Container(
  color: colors.primaryContainer,
  child: Text('Title', style: text.headlineMedium),
);
```

> Avoid hardcoding colors like `Colors.blue` everywhere — use `colorScheme` so dark mode works automatically.

---

## 10. Responsive Design Basics

```dart
import 'package:flutter/material.dart';

class ResponsiveHome extends StatelessWidget {
  const ResponsiveHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Responsive')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 1000) {
            return const _Grid(columns: 4);    // desktop
          } else if (constraints.maxWidth >= 600) {
            return const _Grid(columns: 2);    // tablet
          }
          return const _Grid(columns: 1);      // phone
        },
      ),
    );
  }
}

class _Grid extends StatelessWidget {
  final int columns;
  const _Grid({required this.columns});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: columns,
      padding: const EdgeInsets.all(12),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: List.generate(
        8,
        (i) => Card(child: Center(child: Text('Card ${i + 1}'))),
      ),
    );
  }
}
```

| Tool | Use |
|------|-----|
| `MediaQuery.sizeOf(context)` | Whole screen size |
| `LayoutBuilder` | Space available to *this* widget |
| `Expanded` / `Flexible` | Share space proportionally |
| `Wrap` | Items flow to next line when full |
| `SafeArea` | Avoid notches & system bars |

---

## 11. Build Modes

| Mode | Command | Use | Hot reload | Speed |
|------|---------|-----|------------|-------|
| **Debug** | `flutter run` | Development | ✅ | Slower (JIT) |
| **Profile** | `flutter run --profile` | Performance testing | ❌ | Near-release |
| **Release** | `flutter run --release` / `flutter build` | Production | ❌ | Fastest (AOT) |

> Never judge performance in debug mode — it's intentionally slower.

---

## 12. Pros & Cons

**✅ Pros**
- One codebase for 6 platforms
- Hot reload = very fast development
- Pixel-perfect, consistent UI
- Strong performance (AOT-compiled)
- Excellent docs & big community
- Easy custom designs and animations

**⚠️ Cons**
- Larger app size than a minimal native app (a few MB extra)
- Dart is less widely known than JS/Kotlin/Swift
- Some cutting-edge native APIs need platform channels or plugins
- Web is best for app-like experiences, not SEO-heavy content sites
- UI doesn't automatically adopt new native OS styling (because Flutter draws its own)

---

## 13. Glossary

| Term | Meaning |
|------|---------|
| **Widget** | Immutable description of part of the UI |
| **StatelessWidget** | Widget without mutable state |
| **StatefulWidget** | Widget paired with a `State` object that can change |
| **State** | Data that can change and trigger a rebuild |
| **setState** | Tells Flutter local state changed → rebuild |
| **BuildContext** | A widget's position in the tree |
| **Hot reload** | Inject code changes while keeping app state |
| **Hot restart** | Restart app code, state resets |
| **pub.dev** | Official Dart/Flutter package repository |
| **Package / Plugin** | Reusable library; plugin = includes native code |
| **Platform channel** | Bridge to call native Kotlin/Swift code |
| **Material** | Google's design system (default widgets) |
| **Cupertino** | iOS-style widget set |
| **Impeller / Skia** | Flutter's rendering engines |
| **JIT / AOT** | Just-in-time (debug) / ahead-of-time (release) compilation |
| **Null safety** | Dart feature: variables can't be null unless marked `?` |
| **Future** | A value that will be available later (async) |
| **Stream** | A sequence of async values over time |

---

## 14. What to Learn Next

1. ✅ Read this intro
2. 👉 Work through `README.md` (hands-on samples + Todo app)
3. Build 3 small apps:
   - Profile card (layout)
   - Todo list (state + storage)
   - News/Posts reader (API + navigation)
4. Learn one state management solution well (Provider → Riverpod or Bloc)
5. Explore `go_router`, Firebase, testing, and publishing to the stores

**Official resources**
- Docs: https://docs.flutter.dev
- Flutter architecture overview: https://docs.flutter.dev/resources/architectural-overview
- Understanding constraints: https://docs.flutter.dev/ui/layout/constraints
- Widget of the Week (YouTube): search "Flutter Widget of the Week"
- Try in browser: https://dartpad.dev

---

Welcome to Flutter! 💙
