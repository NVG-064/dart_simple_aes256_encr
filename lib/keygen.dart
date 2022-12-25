import 'dart:convert';

final _chars = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];

String keyGenerator(String key) {
  if (key.isEmpty) {
    // do something else
    return "${key.length}";
  } else if (key.length > 32) {
    return "${key.length}";
  } else {
    // do something else
    return "${key.length}";
  }
}

// Note, I used this for debug only
void main(List<String> args) {
  print(keyGenerator("EXCLUDE"));
}
