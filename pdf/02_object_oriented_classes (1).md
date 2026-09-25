# 🏗️ Dart — Object-Oriented Programming (Classes)

Quick beginner reference: short definitions + sample code.

---

## 🎯 What is a Class?

> A blueprint for creating objects — it bundles data (fields) and behavior (methods) together.

```dart
class Person {
  String name;
  int age;

  // Constructor
  Person(this.name, this.age);

  void greet() {
    print('Hi, I am $name, $age years old.');
  }
}

void main() {
  var p = Person('Tim', 25);
  p.greet(); // Hi, I am Tim, 25 years old.
}
```

---

## 🏭 Constructors

> A constructor is a special method used to create ("construct") an instance of a class. Dart offers several kinds — pick the one that fits how the object should be built.

### 1. Default (Generative) Constructor
> The basic constructor — same name as the class. `this.field` shorthand assigns straight to fields.

```dart
class Person {
  String name;
  int age;

  // Default constructor
  Person(this.name, this.age);
}

void main() {
  var p = Person('Tim', 25);
  print('${p.name}, ${p.age}');
}
```

### 2. Named Constructors
> Extra, alternately-named ways to build the same class — great for common presets.

```dart
class Point {
  double x, y;

  Point(this.x, this.y);

  Point.origin() : x = 0, y = 0;          // named constructor
  Point.fromMap(Map<String, double> m)    // another named constructor
      : x = m['x']!,
        y = m['y']!;
}

void main() {
  var p1 = Point(3, 4);
  var p2 = Point.origin();
  var p3 = Point.fromMap({'x': 1, 'y': 2});
}
```

### 3. Constructor with Initializer List
> Code after `:` runs before the constructor body — used to compute/validate fields (including `final` ones) before the object exists.

```dart
class Rectangle {
  final double width, height;
  final double area;

  Rectangle(this.width, this.height) : area = width * height {
    // body runs AFTER the initializer list
    print('Rectangle created: $width x $height');
  }
}

void main() {
  var r = Rectangle(4, 5);
  print(r.area); // 20
}
```

### 4. Default Parameter Values (Named / Optional)
> Set defaults directly in the constructor signature — curly braces `{}` make params named & optional.

```dart
class Product {
  String name;
  double price;

  Product({this.name = 'Unnamed', this.price = 0.0});
}

void main() {
  var item = Product(name: 'Book', price: 12.5);
  var fallback = Product(); // uses defaults
}
```

### 5. Const Constructor
> Creates **compile-time constant** objects. All fields must be `final`. Reusing the same const values returns the same instance (memory-efficient).

```dart
class ImmutablePoint {
  final double x, y;
  const ImmutablePoint(this.x, this.y);
}

void main() {
  const p1 = ImmutablePoint(0, 0);
  const p2 = ImmutablePoint(0, 0);
  print(identical(p1, p2)); // true — same instance
}
```

### 6. Factory Constructor
> Doesn't always create a new instance — can return a cached object, a subtype, or run logic before construction. Common for singletons & caching.

```dart
class Logger {
  static final Logger _instance = Logger._internal();

  // Private named constructor
  Logger._internal();

  // Factory returns the same instance every time (Singleton)
  factory Logger() {
    return _instance;
  }

  void log(String msg) => print('[LOG] $msg');
}

void main() {
  var l1 = Logger();
  var l2 = Logger();
  print(identical(l1, l2)); // true — same singleton
  l1.log('App started');
}
```

### 7. Redirecting Constructor
> One constructor forwards its work to another constructor in the same class — avoids duplicating logic.

```dart
class Employee {
  String name;
  double salary;

  Employee(this.name, this.salary);

  // Redirects to the main constructor with a default salary
  Employee.intern(String name) : this(name, 0.0);
}

void main() {
  var e1 = Employee('Alice', 5000);
  var e2 = Employee.intern('Bob'); // salary defaults to 0.0
}
```

### Quick Comparison

| Constructor Type | Use When |
|---|---|
| Default | Standard, simple object creation |
| Named | Multiple sensible ways to build the object |
| Initializer list | Need to compute/validate `final` fields before body runs |
| Named/optional params | Fields have sensible defaults, order doesn't matter |
| `const` | Object is truly immutable & known at compile time |
| `factory` | Need caching, singletons, or conditional/subtype return |
| Redirecting | Avoid repeating logic across constructors |

---

## 🔒 Encapsulation (Private Fields)

> A leading underscore `_` makes a field/method private to its file.

```dart
class BankAccount {
  double _balance = 0;

  void deposit(double amount) {
    _balance += amount;
  }

  double get balance => _balance; // getter
}

void main() {
  var account = BankAccount();
  account.deposit(100);
  print(account.balance); // 100
}
```

---

## 🧬 Inheritance

> A class can reuse and extend another class's fields/methods using `extends`.

```dart
class Animal {
  String name;
  Animal(this.name);

  void makeSound() {
    print('$name makes a sound');
  }
}

class Dog extends Animal {
  Dog(String name) : super(name);

  @override
  void makeSound() {
    print('$name barks 🐶');
  }
}

void main() {
  Animal a = Dog('Rex');
  a.makeSound(); // Rex barks 🐶
}
```

---

## 🎭 Abstract Classes & Interfaces

> Abstract classes define a contract — subclasses must implement the methods.

```dart
abstract class Shape {
  double area(); // no body — must be implemented
}

class Circle extends Shape {
  double radius;
  Circle(this.radius);

  @override
  double area() => 3.14 * radius * radius;
}

void main() {
  Shape s = Circle(5);
  print(s.area()); // 78.5
}
```

---

## 🧩 Mixins

> Share behavior across classes without traditional inheritance, using `with`.

```dart
mixin Swimmer {
  void swim() => print('Swimming 🏊');
}

class Fish with Swimmer {}

void main() {
  Fish().swim(); // Swimming 🏊
}
```

---

## 💡 Quick Tip
Use `class` for blueprints, `extends` to inherit, and `abstract class` when you want to force subclasses to implement specific behavior.
