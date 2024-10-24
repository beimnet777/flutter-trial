import 'package:flutter_px/AuthModule/data%20provider/login_provider.dart';

class LoginRepository {
  final LoginProvider provider;
  LoginRepository(this.provider);

  Future login(Map<String, dynamic> user) {
    return provider.loging(user);
  }
}
