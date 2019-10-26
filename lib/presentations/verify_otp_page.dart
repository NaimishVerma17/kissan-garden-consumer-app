import 'package:flutter/material.dart';
import 'package:kissan_garden/models/responses/login_response.dart';
import 'package:kissan_garden/presentations/shared/kisaan_button.dart';
import 'package:kissan_garden/services/auth_service.dart';
import 'package:kissan_garden/services/broadcaster_service.dart';
import 'package:kissan_garden/utils/styles.dart';

class VerifyOtpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VerifyOtpPage();
  }
}

class _VerifyOtpPage extends State<VerifyOtpPage> {
  String _otp;
  bool _isLoading = false;
  String _phoneNo;
  AuthService _authService = AuthService.getInstance();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _phoneNo = ModalRoute.of(context).settings.arguments;
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
                  'Verify OTP',
                  style: Styles.headingText(),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextField(
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  decoration: Styles.getInputDecoration(
                      'Enter 6 digit OTP sent on your mobile no.'),
                  onChanged: (value) {
                    _otp = value;
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                KisaanButton(
                  text: 'Verify OTP',
                  onClick: _verifyOtp,
                ),
                SizedBox(
                  height: 15.0,
                ),
                GestureDetector(
                  onTap: _resendOtp,
                  child: Text(
                    'Resend OTP',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                      color: Styles.subHeadingColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _verifyOtp() async {
    if (_otp.length != 6) {
      Styles.showToast('Please enter a valid OTP');
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      Map<String, String> body = {'phone_number': _phoneNo, 'otp': _otp};
      final LoginResponse response = await _authService.verifyOtp(body);
      print(response.token);
      print(response.data);
      if (response.token.isNotEmpty) {
        BroadcasterService.getInstance()
            .emit(eventType: BroadcasterEventType.loginComplete);
        Navigator.of(context).pop();
      }
    } catch (error) {
      _isLoading = false;
      Styles.showToast(error);
    }
  }

  _resendOtp() {
    print('Resend otp');
  }
}
