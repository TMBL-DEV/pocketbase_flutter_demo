import 'package:pocketbase/pocketbase.dart';

class PocketBaseHelper {
  static final PocketBaseHelper _instance = PocketBaseHelper._internal();
  late PocketBase client;

  factory PocketBaseHelper() {
    return _instance;
  }

  PocketBaseHelper._internal();

  void setPocketbaseUrl(String url) {
    client = PocketBase(url);
  }

  Future<UserModel> register({
    required String email,
    required String password,
    required String passwordConfirm,
  }) {
    return PocketBaseHelper().client.users.create(body: {
      'email': email,
      'password': password,
      'passwordConfirm': passwordConfirm,
    });
  }

  
}
