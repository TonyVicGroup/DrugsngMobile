import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

class Encryption {
  Encryption(this.key, this.data);
  final String key, data;

  static String _encryptWithRSA(String value) {
    final key = RSAKeyParser().parse('<RSA_KEY>');
    final publicKey = RSAPublicKey(key.modulus!, key.exponent!);

    final encrypted = Encrypter(RSA(publicKey: publicKey)).encrypt(value);
    return encrypted.base64;
  }

  static Encryption encryptString(String value) {
    final key = Key.fromSecureRandom(128);
    final encrypted = Encrypter(AES(key)).encrypt(value);
    return Encryption(_encryptWithRSA(key.base64), encrypted.base64);
  }

  // static String decrypt(Encryption value) {
  //   final key = Key.fromBase64(value.key);
  //   final decrypted = Encrypter(AES(key)).decrypt64(value.data);
  //   return decrypted;
  // }
}
