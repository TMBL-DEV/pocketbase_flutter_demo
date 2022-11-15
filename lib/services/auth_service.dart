import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final iv = IV.fromLength(16);

  Future<void> storePassword(String plainPassword, int pincode) async {
    Encrypter encrypter = createEncrypter(pincode);

    var instance = await SharedPreferences.getInstance();
    var encrypted = encrypter.encrypt(plainPassword, iv: iv);

    instance.setString(
      "password",
      encrypted.base64,
    );
  }

  String _getEncryptedPinCode(int pincode) {
    return md5.convert(utf8.encode(pincode.toString())).toString();
  }

  String _decryptStoredPassword(String encryptedPassword, int pincode) {
    return createEncrypter(pincode)
        .decrypt(Encrypted.fromBase64(encryptedPassword), iv: iv);
  }

  Future<String> _getEncryptedStoredPassword() async {
    SharedPreferences instance = await SharedPreferences.getInstance();

    if (instance.containsKey("password")) {
      return instance.getString("password") ?? "";
    }

    return "";
  }

  Encrypter createEncrypter(int pincode) {
    String md5Pincode = _getEncryptedPinCode(pincode);
    final key = Key.fromUtf8(md5Pincode);

    return Encrypter(AES(key));
  }

  Future<String> decryptPassword(int pincode) async {
    return _decryptStoredPassword(
        (await _getEncryptedStoredPassword()), pincode);
  }

  Future<void> storeEmail(String email) async {
    final instance = await SharedPreferences.getInstance();
    instance.setString("email", email);
  }

  Future<String> getStoredEmail() async {
    return (await SharedPreferences.getInstance()).getString("email") ?? "";
  }
}
