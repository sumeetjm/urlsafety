import 'package:shared_preferences/shared_preferences.dart';

class AuthDatasource {
  final SharedPreferences sharedPreferences;

  AuthDatasource(this.sharedPreferences);

  Future<bool> login(final String username, final String password) async {
    if (sharedPreferences.containsKey(username)) {
      if (password == sharedPreferences.getString(username)) {
        sharedPreferences.setBool('loggedIn', true);
        sharedPreferences.setString('loggedUser', username);
        return true;
      }
    }
    return false;
  }

  Future<bool> register(final String username, final String password) async {
    if (sharedPreferences.containsKey(username)) {
      return false;
    }
    sharedPreferences.setString(username, password);
    sharedPreferences.setBool('loggedIn', true);
    sharedPreferences.setString('loggedUser', username);
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
    sharedPreferences.remove('loggedUser');
    return true;
  }
}
