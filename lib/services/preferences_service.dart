import 'package:kissan_garden/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static final PreferencesService _instance =
      new PreferencesService._internal();

  PreferencesService._internal();

  factory PreferencesService() => _instance;

  Future<SharedPreferences> _getInstance() async {
    return SharedPreferences.getInstance();
  }

  setAuthToken(String token) async {
    (await this._getInstance()).setString(Constants.AUTH_TOKEN, token);
  }

  Future<String> getAuthToken() async {
    return (await this._getInstance()).getString(Constants.AUTH_TOKEN);
  }
}
