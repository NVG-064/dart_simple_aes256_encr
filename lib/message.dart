import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:dart_simple_aes256_encr/person.dart';

class Message {
  List<int> message = []; // required
  var tempMessage = '';
  var mac; // generated at 1st time
  var secretKey; // init
  var macAlgorithm; // init
  var nonce; // init
  var cipherAlgorithm; // init
  var secretBox; // generated at 2nd
  var plainText;
  var from = 0; // required
  var to = 0; // required
  var tempMac;

  Future<void> initialize() async {
    macAlgorithm = Hmac.sha512();
    cipherAlgorithm = AesCtr.with256bits(macAlgorithm: macAlgorithm);

    secretKey = await cipherAlgorithm.newSecretKey();
    nonce = cipherAlgorithm.newNonce();
  }

  Future<void> doEncrypt(
      var secretKey, List<int> message, var nonce, var cipherAlgorithm) async {
    var secretBox = await cipherAlgorithm.encrypt(message,
        nonce: nonce, secretKey: secretKey);
    this.message = secretBox.cipherText;
  }

  Future<void> doDecrypt(secretBox, var secretKey, var cipherAlgorithm) async {
    plainText = await cipherAlgorithm.decrypt(secretBox, secretKey: secretKey);
  }

  Future<void> generateMac(var secretKey, List<int> message) async {
    mac = macAlgorithm.calculateMac(message, secretKey: secretKey);
  }

  Future<void> checkMAC(var sharedMAC, var secretKey, var message) async {
    var tempMsg =
        await cipherAlgorithm.decrypt(secretBox, secretKey: secretKey);
    var realMac =
        await macAlgorithm.calculateMac(tempMsg, secretKey: secretKey);

    if (realMac.bytes() != sharedMAC.bytes) {
      print('MAC does not match');
      // do something more
    }
  }

  void getMessage(var userId) {
    if (from != userId) {
      print('Sorry, you are not authorized');
    } else if (to != userId) {
      print('Sorry, you are not authorized');
    } else {
      doDecrypt(secretBox, secretKey, cipherAlgorithm);
      print(Utf8Decoder().convert(message));
    }
  }

  void sendMessage(var message, var userId, var to) {
    this.message = message.codeUnits;
    generateMac(secretKey, message);
    doEncrypt(secretKey, message, nonce, cipherAlgorithm);
  }

  void shareToSender(Person person) {
    person.secretKey = secretKey;
  }

  void readMessage(var from, var to, Person person) {
    checkMAC(mac, person.secretKey, message);
    doDecrypt(secretBox, secretKey, cipherAlgorithm);
  }

  // For debugging purpose
  Future<void> extractSecretKey() async {
    print(await secretKey.extractByets());
  }
}
