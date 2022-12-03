import 'package:cryptography/cryptography.dart';

class Message {
  List<int> message = [];
  var mac = [];
  var secretKey;
  var macAlgorithm;
  var nonce;
  var from = 0;
  var to = 0;

  Future<void> initialize() async {
    var macAlgorithm = Hmac.sha512();
    var cipherAlgorithm = AesCtr.with256bits(macAlgorithm: macAlgorithm);

    secretKey = await cipherAlgorithm.newSecretKey();
    nonce = cipherAlgorithm.newNonce();
  }

  Future<void> doEncrypt(
      var secretKey, List<int> message, var nonce, var cipherAlgorithm) async {
    var secretBox = await cipherAlgorithm.encrypt(message,
        nonce: nonce, secretKey: secretKey);
    this.message = secretBox.cipherText;
  }

  Future<void> doDecrypt(
      var secretBox, var secretKey, var cipherAlgorithm) async {
    var plainText =
        await cipherAlgorithm.decrypt(secretBox, secretKey: secretKey);
  }

  Future<void> generateMac(var secretKey, List<int> message) async {
    mac = macAlgorithm.calculateMac(message, secretKey: secretKey);
  }
}
