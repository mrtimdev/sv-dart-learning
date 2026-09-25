# Flutter Fast Learning — Beginner Guide

A hands-on crash course. Each section has a small, runnable sample. Paste any sample into `lib/main.dart` and run it.

---

## Table of Contents

1. [Setup](#1-setup)
2. [Dart Basics in 10 Minutes](#2-dart-basics-in-10-minutes)
3. [Your First App](#3-your-first-app)
4. [Widgets: Stateless vs Stateful](#4-widgets-stateless-vs-stateful)
5. [Layout: Row, Column, Stack, Container](#5-layout-row-column-stack-container)
6. [Common Widgets](#6-common-widgets)
7. [Lists](#7-lists)
8. [User Input & Forms](#8-user-input--forms)
9. [Navigation Between Screens](#9-navigation-between-screens)
10. [Fetching Data from an API](#10-fetching-data-from-an-api)
11. [Simple State Management (Provider)](#11-simple-state-management-provider)
12. [Saving Data Locally](#12-saving-data-locally)
13. [Mini Project: Todo App](#13-mini-project-todo-app)
14. [Cheat Sheet](#14-cheat-sheet)
15. [Learning Path](#15-learning-path)

---

## 1. Setup

1. Install the Flutter SDK: https://docs.flutter.dev/get-started/install
2. Install **VS Code** (with the Flutter extension) or **Android Studio**.
3. Check everything:

```bash
flutter doctor
```

4. Create and run a project:

```bash
flutter create my_app
cd my_app
flutter run
```

**Project structure (what matters for now):**

```
my_app/
├── lib/
│   └── main.dart      # your code starts here
├── pubspec.yaml       # dependencies & assets
├── android/ ios/ web/ # platform folders (rarely touched)
└── test/              # tests
```

**Hot reload:** save the file (or press `r` in the terminal) to see changes instantly without losing state. `R` = hot restart.

---

## 2. Dart Basics in 10 Minutes

Flutter uses **Dart**. Try these at https://dartpad.dev

```dart
void main() {
  // Variables
  var name = 'Tim';          // type inferred (String)
  String city = 'Phnom Penh';
  int age = 25;
  double price = 9.99;
  bool isActive = true;
  final created = DateTime.now(); // set once at runtime
  const pi = 3.14;                // compile-time constant

  // Null safety
  String? nickname;          // can be null
  print(nickname ?? 'No nickname'); // default if null
  print(nickname?.length);          // safe access -> null

  // String interpolation
  print('Hello $name, you are $age. Next year: ${age + 1}');

  // Lists & Maps
  List<String> fruits = ['apple', 'banana'];
  fruits.add('mango');
  Map<String, int> scores = {'math': 90, 'english': 85};
  print(scores['math']);

  // Loops
  for (var f in fruits) {
    print(f);
  }
  fruits.forEach((f) => print(f.toUpperCase()));

  // Conditions
  if (age >= 18) {
    print('Adult');
  } else {
    print('Minor');
  }

  print(greet('Dara'));
  print(add(2, b: 3));

  var user = User('Sokha', 30);
  user.sayHi();
}

// Functions
String greet(String name) => 'Hi $name';

// Named + optional parameters
int add(int a, {int b = 0}) => a + b;

// Classes
class User {
  final String name;
  final int age;

  User(this.name, this.age);

  void sayHi() => print('Hi, I am $name ($age)');
}
```

**Async (you'll use this for APIs):**

```dart
Future<String> fetchName() async {
  await Future.delayed(const Duration(seconds: 1));
  return 'Loaded!';
}

void main() async {
  print('Loading...');
  final result = await fetchName();
  print(result);
}
```

---

## 3. Your First App

Everything in Flutter is a **widget**. An app is a tree of widgets.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Hello Flutter')),
        body: const Center(
          child: Text('Welcome! 👋', style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}
```

- `MaterialApp` → app root (theme, routes)
- `Scaffold` → page skeleton (app bar, body, FAB, drawer)
- `Center`, `Text` → widgets inside widgets

---

## 4. Widgets: Stateless vs Stateful

| Type | When to use |
|------|-------------|
| `StatelessWidget` | UI never changes by itself (labels, icons, static cards) |
| `StatefulWidget` | UI changes over time (counters, forms, toggles) |

**Counter example (Stateful):**

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: CounterPage()));

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _count = 0;

  void _increment() {
    setState(() {   // tells Flutter to rebuild
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: Text('$_count', style: const TextStyle(fontSize: 48)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

> **Rule:** change data inside `setState(() { ... })`, otherwise the screen won't update.

---

## 5. Layout: Row, Column, Stack, Container

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: LayoutDemo()));

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Layout')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container = box with color, padding, margin, border, size
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('I am a Container'),
            ),
            const SizedBox(height: 16), // spacing

            // Row = horizontal
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.home),
                Icon(Icons.search),
                Icon(Icons.person),
              ],
            ),
            const SizedBox(height: 16),

            // Expanded = fill remaining space
            Row(
              children: [
                Expanded(flex: 2, child: Container(height: 50, color: Colors.red)),
                Expanded(flex: 1, child: Container(height: 50, color: Colors.green)),
              ],
            ),
            const SizedBox(height: 16),

            // Stack = layers on top of each other
            Stack(
              children: [
                Container(width: 150, height: 150, color: Colors.blue),
                const Positioned(
                  bottom: 8,
                  right: 8,
                  child: Icon(Icons.star, color: Colors.yellow, size: 40),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

**Axis quick reference:**

| Widget | mainAxis | crossAxis |
|--------|----------|-----------|
| `Row` | horizontal ↔ | vertical ↕ |
| `Column` | vertical ↕ | horizontal ↔ |

**Common error:** `RenderFlex overflowed` → content too big. Fix with `Expanded`, `Flexible`, or wrap in `SingleChildScrollView`.

---

## 6. Common Widgets

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: WidgetsDemo()));

class WidgetsDemo extends StatefulWidget {
  const WidgetsDemo({super.key});

  @override
  State<WidgetsDemo> createState() => _WidgetsDemoState();
}

class _WidgetsDemoState extends State<WidgetsDemo> {
  bool _switchOn = false;
  bool _checked = false;
  double _slider = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Common Widgets')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Bold text',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            // Images
            Image.network('https://picsum.photos/300/150', height: 150),
            // Image.asset('assets/logo.png'),  // local (register in pubspec.yaml)
            const SizedBox(height: 12),

            // Buttons
            ElevatedButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Elevated pressed')),
              ),
              child: const Text('ElevatedButton'),
            ),
            FilledButton(onPressed: () {}, child: const Text('FilledButton')),
            OutlinedButton(onPressed: () {}, child: const Text('OutlinedButton')),
            TextButton(onPressed: () {}, child: const Text('TextButton')),
            IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),

            // Toggles
            SwitchListTile(
              title: const Text('Notifications'),
              value: _switchOn,
              onChanged: (v) => setState(() => _switchOn = v),
            ),
            CheckboxListTile(
              title: const Text('I agree'),
              value: _checked,
              onChanged: (v) => setState(() => _checked = v ?? false),
            ),
            Slider(
              value: _slider,
              min: 0,
              max: 100,
              label: _slider.round().toString(),
              divisions: 10,
              onChanged: (v) => setState(() => _slider = v),
            ),

            // Card
            const Card(
              child: ListTile(
                leading: CircleAvatar(child: Icon(Icons.person)),
                title: Text('Sokha'),
                subtitle: Text('Developer'),
                trailing: Icon(Icons.chevron_right),
              ),
            ),

            // Dialog
            ElevatedButton(
              onPressed: () => showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Hello'),
                  content: const Text('This is a dialog'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
              child: const Text('Show Dialog'),
            ),

            const SizedBox(height: 12),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
```

**Using local images/fonts** — edit `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/
```

---

## 7. Lists

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: ListDemo()));

class ListDemo extends StatelessWidget {
  const ListDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(50, (i) => 'Item ${i + 1}');

    return Scaffold(
      appBar: AppBar(title: const Text('ListView.builder')),
      // .builder only builds visible items -> fast for long lists
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(items[index]),
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Tapped ${items[index]}')),
            ),
          );
        },
      ),
    );
  }
}
```

**Grid:**

```dart
GridView.builder(
  padding: const EdgeInsets.all(8),
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
  ),
  itemCount: 20,
  itemBuilder: (context, i) => Container(
    color: Colors.teal.shade100,
    alignment: Alignment.center,
    child: Text('Tile $i'),
  ),
)
```

Other options: `ListView.separated` (with dividers), `ListView(children: [...])` (short, static lists).

---

## 8. User Input & Forms

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: LoginPage()));

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    // Always dispose controllers
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Welcome ${_emailCtrl.text}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Email is required';
                  if (!v.contains('@')) return 'Invalid email';
                  return null; // null = valid
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passCtrl,
                obscureText: _obscure,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
                validator: (v) =>
                    (v == null || v.length < 6) ? 'Min 6 characters' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(onPressed: _submit, child: const Text('Login')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## 9. Navigation Between Screens

### Basic push / pop (with passing data both ways)

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: HomeScreen()));

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _result = 'Nothing yet';

  Future<void> _openDetail() async {
    // Send data forward, wait for data back
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const DetailScreen(productName: 'Coffee')),
    );
    if (result != null) setState(() => _result = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Result: $_result'),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _openDetail, child: const Text('Open Detail')),
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String productName;
  const DetailScreen({super.key, required this.productName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(productName)),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context, 'Bought $productName'),
          child: const Text('Buy & Go Back'),
        ),
      ),
    );
  }
}
```

### Named routes

```dart
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (_) => const HomeScreen(),
    '/settings': (_) => const SettingsScreen(),
  },
);

// Navigate
Navigator.pushNamed(context, '/settings');
```

### Bottom navigation bar

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: MainShell()));

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;
  final _pages = const [
    Center(child: Text('Home')),
    Center(child: Text('Search')),
    Center(child: Text('Profile')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
```

> For larger apps, look at the `go_router` package later.

---

## 10. Fetching Data from an API

Add the `http` package:

```bash
flutter pub add http
```

> Android: make sure `android/app/src/main/AndroidManifest.xml` has
> `<uses-permission android:name="android.permission.INTERNET"/>` (needed for release builds).

```dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MaterialApp(home: PostsPage()));

// 1. Model
class Post {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json['id'],
        title: json['title'],
        body: json['body'],
      );
}

// 2. Service
Future<List<Post>> fetchPosts() async {
  final res = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/posts'),
  );
  if (res.statusCode == 200) {
    final List data = jsonDecode(res.body);
    return data.map((e) => Post.fromJson(e)).toList();
  }
  throw Exception('Failed to load posts (${res.statusCode})');
}

// 3. UI with FutureBuilder
class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late Future<List<Post>> _future;

  @override
  void initState() {
    super.initState();
    _future = fetchPosts(); // call once, NOT inside build()
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: FutureBuilder<List<Post>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final posts = snapshot.data!;
          return RefreshIndicator(
            onRefresh: () async {
              setState(() => _future = fetchPosts());
              await _future;
            },
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (_, i) => ListTile(
                title: Text(posts[i].title),
                subtitle: Text(posts[i].body, maxLines: 2, overflow: TextOverflow.ellipsis),
              ),
            ),
          );
        },
      ),
    );
  }
}
```

**POST request:**

```dart
final res = await http.post(
  Uri.parse('https://jsonplaceholder.typicode.com/posts'),
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode({'title': 'Hello', 'body': 'World', 'userId': 1}),
);
print(res.statusCode); // 201
```

---

## 11. Simple State Management (Provider)

`setState` is fine for one screen. When **multiple screens share data**, use a state manager. `provider` is the easiest to start with.

```bash
flutter pub add provider
```

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 1. State class
class CartModel extends ChangeNotifier {
  final List<String> _items = [];
  List<String> get items => List.unmodifiable(_items);
  int get count => _items.length;

  void add(String item) {
    _items.add(item);
    notifyListeners(); // rebuild listeners
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

// 2. Provide it at the top
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartModel(),
      child: const MaterialApp(home: ShopPage()),
    ),
  );
}

// 3. Use it anywhere
class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = ['Coffee', 'Tea', 'Juice', 'Water'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        actions: [
          // context.watch -> rebuilds when cart changes
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('🛒 ${context.watch<CartModel>().count}'),
          ),
        ],
      ),
      body: ListView(
        children: products
            .map((p) => ListTile(
                  title: Text(p),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_shopping_cart),
                    // context.read -> just call, no rebuild
                    onPressed: () => context.read<CartModel>().add(p),
                  ),
                ))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CartPage()),
        ),
        label: const Text('View Cart'),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: cart.items.isEmpty
          ? const Center(child: Text('Cart is empty'))
          : ListView(children: cart.items.map((i) => ListTile(title: Text(i))).toList()),
      floatingActionButton: FloatingActionButton(
        onPressed: cart.clear,
        child: const Icon(Icons.delete),
      ),
    );
  }
}
```

| Method | Use |
|--------|-----|
| `context.watch<T>()` | Inside `build`, rebuilds on change |
| `context.read<T>()` | In callbacks (onPressed), no rebuild |

> Next step after Provider: **Riverpod** or **Bloc**.

---

## 12. Saving Data Locally

For small key-value data (settings, token, flags):

```bash
flutter pub add shared_preferences
```

```dart
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveName(String name) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('name', name);
}

Future<String?> loadName() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('name');
}

Future<void> removeName() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('name');
}
```

For structured/large data → `sqflite`, `drift`, `hive`, or `isar`.
For secrets (tokens) → `flutter_secure_storage`.

---

## 13. Mini Project: Todo App

Combines: StatefulWidget, TextField, ListView, Checkbox, Dismissible, and SharedPreferences.

```bash
flutter pub add shared_preferences
```

```dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const TodoPage(),
    );
  }
}

class Todo {
  String title;
  bool done;
  Todo(this.title, {this.done = false});

  Map<String, dynamic> toJson() => {'title': title, 'done': done};
  factory Todo.fromJson(Map<String, dynamic> j) => Todo(j['title'], done: j['done']);
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _ctrl = TextEditingController();
  List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('todos');
    if (raw != null) {
      final list = jsonDecode(raw) as List;
      setState(() => _todos = list.map((e) => Todo.fromJson(e)).toList());
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('todos', jsonEncode(_todos.map((t) => t.toJson()).toList()));
  }

  void _add() {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    setState(() => _todos.insert(0, Todo(text)));
    _ctrl.clear();
    _save();
  }

  void _toggle(int i) {
    setState(() => _todos[i].done = !_todos[i].done);
    _save();
  }

  void _remove(int i) {
    final removed = _todos[i];
    setState(() => _todos.removeAt(i));
    _save();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleted "${removed.title}"'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() => _todos.insert(i, removed));
            _save();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final remaining = _todos.where((t) => !t.done).length;

    return Scaffold(
      appBar: AppBar(title: Text('Todos ($remaining left)')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ctrl,
                    decoration: const InputDecoration(
                      hintText: 'What needs doing?',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _add(),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(onPressed: _add, child: const Text('Add')),
              ],
            ),
          ),
          Expanded(
            child: _todos.isEmpty
                ? const Center(child: Text('No todos yet 🎉'))
                : ListView.builder(
                    itemCount: _todos.length,
                    itemBuilder: (_, i) {
                      final t = _todos[i];
                      return Dismissible(
                        key: ObjectKey(t),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 16),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (_) => _remove(i),
                        child: CheckboxListTile(
                          value: t.done,
                          onChanged: (_) => _toggle(i),
                          title: Text(
                            t.title,
                            style: TextStyle(
                              decoration: t.done ? TextDecoration.lineThrough : null,
                              color: t.done ? Colors.grey : null,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
```

**Challenges to extend it:**
- [ ] Add an edit dialog when tapping a todo
- [ ] Add filter tabs: All / Active / Done
- [ ] Move state into a `ChangeNotifier` with Provider
- [ ] Add a due date with `showDatePicker`

---

## 14. Cheat Sheet

### Commands

| Command | What it does |
|---------|--------------|
| `flutter create app_name` | New project |
| `flutter run` | Run on connected device/emulator |
| `flutter run -d chrome` | Run on web |
| `flutter devices` | List devices |
| `flutter pub add pkg` | Add a package |
| `flutter pub get` | Install dependencies |
| `flutter clean` | Clear build cache (fixes weird errors) |
| `flutter build apk --release` | Android APK |
| `flutter build appbundle` | Android Play Store bundle |
| `flutter build ios` | iOS build (macOS only) |
| `dart format .` | Format code |
| `flutter analyze` | Find issues |

### Widget quick picks

| Need | Widget |
|------|--------|
| Spacing | `SizedBox`, `Padding`, `Spacer` |
| Box styling | `Container`, `DecoratedBox` |
| Horizontal / vertical | `Row` / `Column` |
| Overlay | `Stack` + `Positioned` |
| Fill space | `Expanded`, `Flexible` |
| Scroll | `SingleChildScrollView`, `ListView` |
| Tap anything | `GestureDetector`, `InkWell` |
| Rounded image | `ClipRRect` |
| Async data | `FutureBuilder`, `StreamBuilder` |
| Responsive | `MediaQuery.sizeOf(context)`, `LayoutBuilder` |

### Popular packages

| Package | Purpose |
|---------|---------|
| `http` / `dio` | Networking |
| `provider` / `flutter_riverpod` / `flutter_bloc` | State management |
| `go_router` | Routing |
| `shared_preferences` | Simple local storage |
| `sqflite` / `drift` | SQL database |
| `cached_network_image` | Image caching |
| `image_picker` | Camera / gallery |
| `intl` | Date & number formatting |
| `flutter_secure_storage` | Secure token storage |

### Common beginner mistakes

1. Forgetting `setState` → UI doesn't update.
2. Calling an API inside `build()` → runs on every rebuild. Use `initState`.
3. Not disposing `TextEditingController` → memory leaks.
4. `ListView` inside `Column` without `Expanded` → "unbounded height" error.
5. Using `context` after `await` when the widget may be gone → check `if (!mounted) return;`.
6. Missing `const` → slower rebuilds (the analyzer will hint you).

---

## 15. Learning Path

| Week | Focus | Goal |
|------|-------|------|
| 1 | Dart basics, widgets, layout | Rebuild a static profile screen |
| 2 | Stateful widgets, forms, lists | Build the Todo app (Section 13) |
| 3 | Navigation, APIs, JSON | App that lists & shows details from an API |
| 4 | Provider / Riverpod, local storage | Shopping cart with persistence |
| 5+ | go_router, Firebase, testing, release | Publish a small app |

**Resources**
- Official docs: https://docs.flutter.dev
- Codelabs: https://docs.flutter.dev/codelabs
- Widget catalog: https://docs.flutter.dev/ui/widgets
- Packages: https://pub.dev
- Dart playground: https://dartpad.dev

---

Happy coding! 🚀
