import 'package:kissan_garden/models/login_response.dart';
import 'package:kissan_garden/models/user.dart';
import 'package:kissan_garden/services/api_service.dart';
import 'package:kissan_garden/services/broadcaster_service.dart';
import 'package:kissan_garden/services/preferences_service.dart';

class AuthService extends ApiService {
  AuthService._();

  static final AuthService _instance = AuthService._();

  factory AuthService.getInstance() => _instance;
  final PreferencesService _preferencesService = PreferencesService();

  final BroadcasterService _broadcasterService =
      BroadcasterService.getInstance();

  Future<Map<String, dynamic>> sendOtp(Map<String, String> body) {
    return this.post('/api/send-otp', body: body, useAuthHeaders: false);
  }

  Future<LoginResponse> verifyOtp(Map<String, String> body) async {
    try {
      final response = await this
          .post('/api/authenticate', body: body, useAuthHeaders: false);
      print(response);
      await _preferencesService.setAuthToken(response['token']);
      await _preferencesService
          .setLoggedInUser(User.fromJson(response['data']));

      return LoginResponse(response['token'], User.fromJson(response['data']));
    } catch (error) {
      throw (error);
    }
  }

  Future<void> logout() async {
    try {
      await _preferencesService.removeAuthToken();
      await _preferencesService.removeLoggedInUser();
      _broadcasterService.emit(eventType: BroadcasterEventType.logout);
    } catch (error) {
      throw (error);
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _preferencesService.getAuthToken();
    print(token);
    if (token == null || token.isEmpty)
      return false;
    else
      return true;
  }
}
