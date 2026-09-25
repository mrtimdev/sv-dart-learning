void main() {
  var name = 'Tim'; // type inferred: String
  String city = 'Phnom Penh';
  int age = 25;
  double price = 9.99;
  bool isOnline = true;
  dynamic anything = 42; // can change type later

  const pi = 3.14159; // compile-time constant
  final today = DateTime.now(); // set once, at runtime

  String hello = "Hello world";

  print(hello);

  // Nullable types

  String? nickname; // nullable
  nickname ??= 'Guest'; // assign if null
  print(nickname);

  int? score;

  print(score ?? 0); // fallback value if null

  if (score != null) {
    print('Score is $score');
  } else {
    print('Score is not set');
  }

  int age2 = age;

  // Control Flow Runs code based on a condition.
  if (age2 >= 18) {
    print('Adult');
  } else if (age2 >= 13) {
    print('Teenager');
  } else {
    print('Child');
  }

  String grade = 'Bac';

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

  //   for loop
  // Repeats code a set number of times.

  //
  for (int i = 0; i < 5; i++) {
    print('\n');

    print('\n');
    print('Count: $i');
  }

  // for-in loop (great for lists)
  List<String> fruits = ['apple', 'banana', 'mango'];

  for (var fruit in fruits) {
    print(fruit);
  }

  // while loop
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

  //   Ternary & Logical Operators
  // Shorthand conditionals.

  String result = age >= 18 ? 'Adult' : 'Minor';

  if (age >= 18) {
    print('You are an adult.');
  } else {
    print('You are a minor.');
  }

  bool isMember = true;
  bool hasCoupon = false;
  if (isMember || hasCoupon) {
    print('Discount applied');
  }
}
