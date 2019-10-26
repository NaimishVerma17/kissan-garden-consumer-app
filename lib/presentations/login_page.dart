import 'package:flutter/material.dart';
import 'package:kissan_garden/presentations/shared/kisaan_button.dart';
import 'package:kissan_garden/services/auth_service.dart';
import 'package:kissan_garden/utils/Validators.dart';
import 'package:kissan_garden/utils/route_utils.dart';
import 'package:kissan_garden/utils/styles.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  final GlobalKey<FormState> _globalKey = new GlobalKey();
  AuthService _authService = AuthService.getInstance();
  bool _isLoading = false;
  String _phoneNo;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 25.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/images/user.png'),
                  height: 100.0,
                  width: 100.0,
                ),
                Text(
                  'Login using OTP',
                  style: Styles.headingText(),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'Enter your mobile number, we will send you an OPT to verify.',
                  textAlign: TextAlign.center,
                  style: Styles.subHeadingText(),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Form(
                  key: _globalKey,
                  child: TextFormField(
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    validator: Validators.validatePhoneNo,
                    decoration: Styles.getInputDecoration(
                        'Enter your 10 digit mobile no.'),
                    onSaved: (value) {
                      _phoneNo = value;
                    },
                  ),
                ),
                _isLoading ? CircularProgressIndicator() : Container(),
                SizedBox(
                  height: 12.0,
                ),
                KisaanButton(
                  text: 'Request OTP',
                  onClick: _isLoading ? null : _login,
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'By signing in, you agree to our Terms and Conditions.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Styles.subHeadingColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _login() async {
    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      Map<String, String> body = {"phone_number": null};
      setState(() {
        _isLoading = true;
      });
      try {
        await _authService.sendOtp(body);
        Navigator.pushReplacementNamed(context, RouteUtils.verifyOTP);
        _isLoading = false;
      } catch (error) {
        setState(() {
          _isLoading = false;
          Styles.showToast(error);
        });
      }
    }
  }
}
