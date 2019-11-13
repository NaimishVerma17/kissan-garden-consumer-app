import 'package:kissan_garden/models/user.dart';

class LoginResponse {
  String token;
  User data;

  LoginResponse(this.token, this.data);
}
