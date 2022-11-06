import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

class CryptoUtils {
  static final vi = IV.fromBase64("zU0KkaYUjFTE1ohR4veVBw==");

  static String encrypt(String data, String password) {
    print(vi);
    try {
      final key = Key(sha256.convert(utf8.encode(password)).bytes);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final encrypted = encrypter.encrypt(data, iv: vi);

      print(encrypted.base64);
      return encrypted.base64;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static String decrypt(String encoded, String password) {
    try {
      final key = Key(sha256.convert(utf8.encode(password)).bytes);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final decrypted = encrypter.decrypt(Encrypted.fromBase64(encoded), iv: vi);

      print(decrypted);
      return decrypted;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
