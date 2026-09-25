# 🔤 Dart — Variables & Control Flow

Quick beginner reference: short definitions + sample code.

---

## 📦 Variables & Data Types

> Containers that store data. Dart is statically typed but supports type inference.

```dart
void main() {
  var name = 'Tim';        // type inferred: String
  String city = 'Phnom Penh';
  int age = 25;
  double price = 9.99;
  bool isOnline = true;
  dynamic anything = 42;   // can change type later

  const pi = 3.14159;      // compile-time constant
  final today = DateTime.now(); // set once, at runtime

  print('$name from $city, age $age');
}
```

**`var` vs `final` vs `const`:**
| Keyword | Meaning |
|---|---|
| `var` | Type inferred, value can change |
| `final` | Value set once, at runtime |
| `const` | Value set once, at compile time |

---

## ❓ Null Safety

> A variable can't be `null` unless marked with `?`. Prevents null-reference crashes.

```dart
String? nickname;             // nullable
nickname ??= 'Guest';         // assign if null
print(nickname);

int? score;
print(score ?? 0);            // fallback value if null
```

---

## 🔁 Control Flow

### if / else
> Runs code based on a condition.

```dart
int age = 18;

if (age >= 18) {
  print('Adult');
} else if (age >= 13) {
  print('Teenager');
} else {
  print('Child');
}
```

### switch
> Compares one value against multiple cases.

```dart
String grade = 'B';

switch (grade) {
  case 'A':
    print('Excellent');
    break;
  case 'B':
    print('Good');
    break;
  default:
    print('Keep trying');
}
```

### for loop
> Repeats code a set number of times.

```dart
for (int i = 0; i < 5; i++) {
  print('Count: $i');
}

// for-in loop (great for lists)
List<String> fruits = ['apple', 'banana', 'mango'];
for (var fruit in fruits) {
  print(fruit);
}
```

### while / do-while
> Repeats code while a condition is true.

```dart
int i = 0;
while (i < 3) {
  print('while: $i');
  i++;
}

int j = 0;
do {
  print('do-while: $j');
  j++;
} while (j < 3);
```

### Ternary & Logical Operators
> Shorthand conditionals.

```dart
int age = 20;
String result = age >= 18 ? 'Adult' : 'Minor';

bool isMember = true;
bool hasCoupon = false;
if (isMember || hasCoupon) {
  print('Discount applied');
}
```

---

## 💡 Quick Tip
Use `final` by default for values that won't be reassigned — it makes your code safer and easier to reason about.
