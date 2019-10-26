import 'package:kissan_garden/services/api_service.dart';

class AuthService extends ApiService {
  AuthService._();

  static final AuthService _instance = AuthService._();

  factory AuthService.getInstance() => _instance;
}
