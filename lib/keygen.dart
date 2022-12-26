import 'dart:convert';
import 'dart:math';

final _chars = [
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
  "M",
  "N",
  "O",
  "P",
  "Q",
  "R",
  "S",
  "T",
  "U",
  "V",
  "W",
  "X",
  "Y",
  "Z",
  "0",
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  " ",
  "!",
  "@",
  "#",
  "%",
  "^",
  "*",
  "(",
  ")",
  "-",
  "_",
  "=",
  "+",
  "<",
  ">"
];

String keyGenerator(String key) {
  int maxIteration = 32;

  if (key.isNotEmpty && key.length < 32) {
    maxIteration = 32 - key.length;
    return key + generate(maxIteration);
  } else if (key.length > 32) {
    return key.substring(0, 32);
  } else if (key.length == 32) {
    return key;
  } else {
    return generate(maxIteration);
  }
}

int randNumGenerator(int max) {
  return Random.secure().nextInt(max);
}

String generate(int maxIteration) {
  String randChar = "";

  for (int i = 0; i < maxIteration; i++) {
    randChar += _chars[randNumGenerator(_chars.length - 1)];
  }
  return randChar;
}

// Note, I used this for debug only
// void main(List<String> args) {
//   print(keyGenerator("ThisIsMyFuckingSecretKeyDoNotTouchIt")); // length 36
//   print(
//       "${keyGenerator("This Is My Fucking Secret Key!!!")}, also encoded as: ${utf8.encode(keyGenerator("This Is My Fucking Secret Key!!!"))}"); // length 32
//   print(keyGenerator("Fuck! ")); // length 6
//   // print('${_chars.length}'); // List length 36 (last index + 1)
// }
