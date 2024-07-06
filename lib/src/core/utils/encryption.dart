import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

class Encryption {
  final String key, data;
  const Encryption(this.key, this.data);

  factory Encryption.encryptString(String value) {
    final key = Key.fromSecureRandom(128);
    final encrypted = Encrypter(AES(key)).encrypt(value);
    return Encryption(_encryptWithRSA(key.base64), encrypted.base64);
  }

  static String decrypt(Encryption value) {
    final key = Key.fromBase64(value.key);
    final decrypted = Encrypter(AES(key)).decrypt64(value.data);
    return decrypted;
  }

  static final _rSAEncrypter = Encrypter(RSA(
    publicKey: RSAKeyParser().parse('<RSA_KEY>') as RSAPublicKey,
  ));

  static String _encryptWithRSA(String value) {
    final encrypted = _rSAEncrypter.encrypt(value);
    return encrypted.base64;
  }
}
