import 'package:flutter/material.dart';
import 'package:kissan_garden/presentations/shared/kisaan_button.dart';
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
  String _phoneNo;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
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
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    validator: Validators.validatePhoneNo,
                    decoration: Styles.getInputDecoration(
                        'Enter your 10 digit mobile no.'),
                    onSaved: (value) {
                      _phoneNo = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                KisaanButton(
                  text: 'Request OTP',
                  onClick: _login,
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'By signing in, you agree to our Terms and Conditions.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.0,
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

  _login() {
    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      print(_phoneNo);
      Navigator.pushNamed(context, RouteUtils.verifyOTP);
    }
    ;
  }
}
