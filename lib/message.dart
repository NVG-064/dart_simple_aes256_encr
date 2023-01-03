import 'dart:convert';
import 'package:cryptography/cryptography.dart';
import 'package:dart_simple_aes256_encr/keygen.dart';

class Message {
  List<int> message = []; // required
  // var tempMessage = '';
  var from = 0; // required
  var to = 0; // required
  var macStatus = '';

  Future<void> doSecureBox(List<int> message, String key) async {
    var macAlgorithm = Hmac.sha512();
    var cipherAlgorithm = AesCtr.with256bits(macAlgorithm: macAlgorithm);
    var cipherSecretKey = await cipherAlgorithm.newSecretKeyFromBytes(keyGenerator(key));
    var cipherNonce = cipherAlgorithm.newNonce();

    var fromSecretKey = cipherSecretKey;
    var toSecretKey = cipherSecretKey;

    // Calculate HMAC before encrypt
    var fromMAC =
        await macAlgorithm.calculateMac(message, secretKey: fromSecretKey);

    // SecretBox is like an isolated box
    var secretBox = await cipherAlgorithm.encrypt(message,
        secretKey: cipherSecretKey, nonce: cipherNonce);

    // print(
    //     'PlainText  : ${Utf8Decoder().convert(message)} as integer: $message');
    // print('=======================================');
    // print('MAC 2      : ${mac.bytes}');
    // print('Nonce      : ${secretBox.nonce}');
    // print('Secret Key : $cipherSecretKey');
    // print('Saved SK   : $secretKey');
    // print('=======================================');
    // print('Ciphertext : ${secretBox.cipherText}');

    // Do decrypt
    this.message =
        await cipherAlgorithm.decrypt(secretBox, secretKey: toSecretKey);

    var toMAC =
        await macAlgorithm.calculateMac(message, secretKey: toSecretKey);

    await Future.delayed(Duration(seconds: 3));

    macStatus = getMACStatus(fromMAC, toMAC);

    print('\nMessage successfully sent');

    // print('New MAC    : ${(newMAC.bytes != mac.bytes) ? "true" : "false"}');
    // print('Decrypted  : ${Utf8Decoder().convert(clearText)}');
  }

  String getMACStatus(var fromMAC, var toMAC) {
    if (fromMAC == toMAC) {
      return "Message integrity verified";
    } else {
      return "Message integrity not verified";
    }
  }

  String getMessages(int id) {
    if (from == id || to == id) {
      return utf8.decode(message);
    } else {
      return '';
    }
  }

  // Future<void> initialize() async {
  //   macAlgorithm = Hmac.sha512();
  //   cipherAlgorithm = AesCtr.with256bits(macAlgorithm: macAlgorithm);

  //   secretKey = await cipherAlgorithm.newSecretKey();
  //   nonce = cipherAlgorithm.newNonce();
  // }

  // Future<void> doEncrypt(
  //     var secretKey, List<int> message, var nonce, var cipherAlgorithm) async {
  //   var secretBox = await cipherAlgorithm.encrypt(message,
  //       nonce: nonce, secretKey: secretKey);
  //   this.message = secretBox.cipherText;
  // }

  // Future<void> doDecrypt(secretBox, var secretKey, var cipherAlgorithm) async {
  //   plainText = await cipherAlgorithm.decrypt(secretBox, secretKey: secretKey);
  // }

  // Future<void> generateMac(var secretKey, List<int> message) async {
  //   mac =
  //       macAlgorithm.calculateMac(tempMessage.codeUnits, secretKey: secretKey);
  // }

  // Future<void> checkMAC(var sharedMAC, var secretKey, var message) async {
  //   var tempMsg =
  //       await cipherAlgorithm.decrypt(secretBox, secretKey: secretKey);
  //   var realMac =
  //       await macAlgorithm.calculateMac(tempMsg, secretKey: secretKey);

  //   if (realMac.bytes() != sharedMAC.bytes) {
  //     print('MAC does not match');
  //     // do something more
  //   }
  // }

  // void getMessage(var userId) {
  //   if (from != userId) {
  //     print('Sorry, you are not authorized');
  //   } else if (to != userId) {
  //     print('Sorry, you are not authorized');
  //   } else {
  //     doDecrypt(secretBox, secretKey, cipherAlgorithm);
  //     print(Utf8Decoder().convert(message));
  //   }
  // }

  // void sendMessage(var userId, var to) {
  //   message = tempMessage.codeUnits;
  //   generateMac(secretKey, message);
  //   doEncrypt(secretKey, message, nonce, cipherAlgorithm);
  // }

  // void shareToSender(Person person) {
  //   person.secretKey = secretKey;
  // }

  // void readMessage(var from, var to, Person person) {
  //   checkMAC(mac, person.secretKey, message);
  //   doDecrypt(secretBox, secretKey, cipherAlgorithm);
  // }

  // // For debugging purpose
  // Future<void> extractSecretKey() async {
  //   print(await secretKey.extractBytes());
  // }
}
