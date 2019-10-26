import 'package:kissan_garden/services/api_service.dart';

class AuthService extends ApiService {
  AuthService._();

  static final AuthService _instance = AuthService._();

  factory AuthService.getInstance() => _instance;

  Future sendOtp(Map<String, String> body) {
    return this.post('/api/send-otp', body: body, useAuthHeaders: false);
  }
}
