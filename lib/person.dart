class Person {
  var _name = '';
  var _id = -1;
  var _secretKey;
  var _nonce;
  var _mac;
  List<int> _ciphertext = [];
  var _onlyToUserId;

  Person(name, id) {
    _name = name;
    _id = id;
  }

  String getName(id) {
    if (id == _id) {
      return _name;
    } else {
      return '';
    }
  }

  set name(name) {
    _name = name;
  }

  get id {
    return _id;
  }

  set id(id) {
    _id = (id >= 0) ? id : -1;
  }
}
