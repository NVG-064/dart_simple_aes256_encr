class Person {
  var _name;
  var _id;
  var _secretKey;
  var _nonce;
  var _mac;
  List<int> _ciphertext = [];
  var _onlyToUserId;

  Person(
    name,
    id,
    ciphertext, onlyToUserId, 
  ) {
    _name = name;
    _id = id;
    _ciphertext = ciphertext;
  }

  String get name {
    return _name;
  }

  set name(name) {
    _name = name;
  }

  int get id {
    return _id;
  }

  set id(id) {
    _id = (id >= 0) ? id : 0;
  }

  List get cipherText {
    return _ciphertext;
  }

  set cipherText(ciphertext) {
    _ciphertext = ciphertext;
  }

  int get onlyToUserId {
    return _onlyToUserId;
  }

  set onlyToUserId(onlyToUserId) {
    _onlyToUserId = (onlyToUserId >= 0) ? onlyToUserId : 0;
  }
}
