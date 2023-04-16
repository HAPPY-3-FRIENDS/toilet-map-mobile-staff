import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository {
  Future<int?> getAccountId() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt("accountId");
  }

  Future<String?> getAccessToken() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("accessToken");
  }
}