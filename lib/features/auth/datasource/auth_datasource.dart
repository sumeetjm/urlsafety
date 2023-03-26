import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthDatasource {
  final SharedPreferences sharedPreferences;

  AuthDatasource(this.sharedPreferences);

  Future<bool> login() async {
    sharedPreferences.setBool('loggedIn', true);
    return true;
  }

  Future<bool> register() async {
    sharedPreferences.setBool('loggedIn', true);
    return true;
  }

  Future<bool> getLoggedInUser() async {
    if (sharedPreferences.containsKey('loggedIn')) {
      return sharedPreferences.getBool('loggedIn') ?? false;
    } else {
      return false;
    }
  }

  Future<bool> logout() async {
    sharedPreferences.setBool('loggedIn', false);
    return true;
  }
}
