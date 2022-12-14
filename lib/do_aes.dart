import 'package:cryptography/cryptography.dart';
import 'dart:convert';

class doAES {
    var macAlgorithm = Hmac.sha512();
    var cipherAlgorithm = AesCtr.with256bits(macAlgorithm: macAlgorithm);
    var cipherSecretKey = await cipherAlgorithm.newSecretKey();
    var cipherNonce = cipherAlgorithm.newNonce();

  Future<void> doSomething() async {
    var macAlgorithm = Hmac.sha512();
    var cipherAlgorithm = AesCtr.with256bits(macAlgorithm: macAlgorithm);
    var cipherSecretKey = await cipherAlgorithm.newSecretKey();
    var cipherNonce = cipherAlgorithm.newNonce();

// SecretBox mirip seperti kotak yang terisolasi
    var secretBox = await cipherAlgorithm.encrypt(plainText,
        secretKey: cipherSecretKey, nonce: cipherNonce);

    var mac =
        await macAlgorithm.calculateMac(plainText, secretKey: cipherSecretKey);

    print(
        'PlainText  : ${Utf8Decoder().convert(plainText)} as integer: $plainText');
    print('=======================================');
    print('MAC        : ${secretBox.mac.bytes}');
    print('MAC 2      : ${mac.bytes}');
    print('Nonce      : ${secretBox.nonce}');
    print('Secret Key : ${await cipherSecretKey.extractBytes()}');
    print('=======================================');
    print('Ciphertext : ${secretBox.cipherText}');

    var clearText =
        await cipherAlgorithm.decrypt(secretBox, secretKey: cipherSecretKey);

    var newMac =
        await macAlgorithm.calculateMac(clearText, secretKey: cipherSecretKey);

    print('New MAC    : ${(newMac.bytes != mac.bytes) ? "true" : "false"}');
    print('Decrypted  : ${Utf8Decoder().convert(clearText)}');
  }
}
