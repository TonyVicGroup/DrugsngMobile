import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';
// import 'package:flutter/foundation.dart' as f;

class Encryption {
  ///Values in base64
  final String key, data;
  const Encryption(this.key, this.data);

  Map<String, String> toMap() => {'data': data, 'key': key};

  @override
  String toString() => 'Encryption($key, $data)';

  ///

  static final _encryptionIV = IV.fromUtf8('DrugsngPassword');
  factory Encryption.encryptString(String value) {
    final key = Key.fromSecureRandom(16);
    final encrypted = Encrypter(AES(key, mode: AESMode.ecb))
        .encrypt(value, iv: _encryptionIV);

    return Encryption(_encryptKey(key), encrypted.base64);
  }

  static final _rSAEncrypter = Encrypter(RSA(
      publicKey: RSAKeyParser().parse(
    '''-----BEGIN PUBLIC KEY-----
MIGeMA0GCSqGSIb3DQEBAQUAA4GMADCBiAKBgGpqQk8BJWGL7qBAWGeAFTEYcsm7
1vK2YwlPw+2HeqyDPqc4fyg8sCdo6qABXhQPnjWFs49E792QZiwmzEsSMU1ML0vL
spToThU9kpEYHyc9xObdpQuc3NXF8ilMJWOVOEA16x/HPwMBtnG6f446yUoT2tQg
qrMgAETknl4FkAjBAgMBAAE=
-----END PUBLIC KEY-----''',
  ) as RSAPublicKey));
  static String _encryptKey(Key key) {
    final encrypted = _rSAEncrypter.encrypt(key.base64);
    return encrypted.base64;
  }

//   static final _rSA2Encrypter = Encrypter(RSA(
//     privateKey: RSAKeyParser().parse('''-----BEGIN RSA PRIVATE KEY-----
// MIICWwIBAAKBgGpqQk8BJWGL7qBAWGeAFTEYcsm71vK2YwlPw+2HeqyDPqc4fyg8
// sCdo6qABXhQPnjWFs49E792QZiwmzEsSMU1ML0vLspToThU9kpEYHyc9xObdpQuc
// 3NXF8ilMJWOVOEA16x/HPwMBtnG6f446yUoT2tQgqrMgAETknl4FkAjBAgMBAAEC
// gYBbBg01+ur4p3M0DBYSYhK+bgUx3cSc07me62XSNYKPMaxT6RWLW23qJ+oZd1H7
// ouhXK8hNklACm1NqDL3OsP8N3u6G21K1yKdIjAIv0BJ7N/JlE0FtVXt3cCkD3iQE
// zFs2N8LzURPfShuiKZ8tXUW9cnXhyySFqKKSZsmoyOtL4QJBAKaXK4kCTCNA70NX
// oiwvkU+Ey1u8N0JhVQhZ57VqIqlUSdMt7q1cHwxNMzjcn3Iv1mifsEduMY3Y7K9U
// Ft0FpTUCQQCjhz1E0+rvpQgBQBzchsh9vzsE71bD3COgmBnOvOu0g7+lEc7MWPJ0
// E/bivJMnwVfdqy/5GfETRX+RIE2FjgLdAkAEjCnfEpX7fGFLqE+//whrcEeQ2IF1
// qWyFztZ5aE1L7AYb4qwaRWJ/lnfofHVJy66BqqJIQOTPZ3WGj7gUDnxlAkEAnCMx
// 5fjt1lld1kvQAuQSpLYldSXNU39q6Rixc4tBBv/QyZzCNq0q+phhX8asPwZFjhq4
// 2IDjhQITto8AVeftZQJAKa6Z3mLVaeAmuTjTAGvE8EdA6RFIcq/kmwzdy/B4jSA4
// biv6nw0XoziSJQbQEf8Uiibl3V8CT8YSkt1L5ON3Hg==
// -----END RSA PRIVATE KEY-----''') as RSAPrivateKey,
//   ));

//   @f.visibleForTesting
//   String decrypt() {
//     final key = _rSA2Encrypter.decrypt64(this.key);
//     final data = Encrypter(AES(Key.fromBase64(key), mode: AESMode.ecb))
//         .decrypt64(this.data, iv: _encryptionIV);

//     return data;
//   }
}
