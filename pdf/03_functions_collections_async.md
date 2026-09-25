# ⚡ Dart — Functions, Collections & Async

Quick beginner reference: short definitions + sample code.

---

## 🧮 Functions

> Reusable blocks of code that take input (parameters) and produce output (return value).

```dart
int add(int a, int b) {
  return a + b;
}

// Arrow syntax (short one-liners)
int multiply(int a, int b) => a * b;

void main() {
  print(add(2, 3));       // 5
  print(multiply(4, 5));  // 20
}
```

### Named & Optional Parameters
> Makes function calls more readable and flexible.

```dart
void greet({String name = 'Guest', int age = 0}) {
  print('Hello $name, age $age');
}

void main() {
  greet(name: 'Tim', age: 25);
  greet(); // uses defaults
}
```

### Functions as Values
> Dart treats functions as first-class objects — you can pass them around.

```dart
void printResult(int a, int b, int Function(int, int) operation) {
  print(operation(a, b));
}

void main() {
  printResult(3, 4, (a, b) => a + b); // 7
}
```

---

## 📚 Collections

### List
> An ordered, indexable group of items.

```dart
List<String> fruits = ['apple', 'banana', 'mango'];
fruits.add('grape');
print(fruits[0]);           // apple
print(fruits.length);       // 4

for (var f in fruits) {
  print(f);
}
```

### Map
> Key-value pairs.

```dart
Map<String, int> scores = {'math': 90, 'science': 85};
scores['english'] = 88;
print(scores['math']);      // 90

scores.forEach((key, value) => print('$key: $value'));
```

### Set
> A collection of unique values (no duplicates).

```dart
Set<int> uniqueNumbers = {1, 2, 2, 3};
print(uniqueNumbers);       // {1, 2, 3}
```

### Handy Collection Methods
> Common one-liners for transforming data.

```dart
List<int> numbers = [1, 2, 3, 4, 5];

var doubled = numbers.map((n) => n * 2).toList();
var evens = numbers.where((n) => n % 2 == 0).toList();
var total = numbers.reduce((a, b) => a + b);

print(doubled); // [2, 4, 6, 8, 10]
print(evens);   // [2, 4]
print(total);   // 15
```

---

## ⏳ Async / Await

> Handles tasks that take time (network calls, file I/O) without freezing the app.

```dart
Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Data loaded!';
}

void main() async {
  print('Loading...');
  String result = await fetchData();
  print(result); // Data loaded! (after 2 sec)
}
```

### Handling Errors
> Use `try/catch` with async code.

```dart
Future<void> riskyTask() async {
  try {
    await Future.delayed(Duration(seconds: 1));
    throw Exception('Something went wrong');
  } catch (e) {
    print('Caught error: $e');
  }
}
```

### Streams (Multiple Async Values)
> Like a `Future`, but can emit many values over time.

```dart
Stream<int> countStream() async* {
  for (int i = 1; i <= 3; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

void main() async {
  await for (var count in countStream()) {
    print(count); // 1, 2, 3 (one per second)
  }
}
```

---

## 💡 Quick Tip
Use `.map()`, `.where()`, and `.reduce()` instead of manual loops when transforming lists — it's shorter and more idiomatic Dart.
