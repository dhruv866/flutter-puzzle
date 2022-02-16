import 'package:shared_preferences/shared_preferences.dart';

set_login_data(bool log, String name) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs
    ..setBool('islogin', true)
    ..setString('name', name);
}