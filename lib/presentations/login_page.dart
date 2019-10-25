import 'package:flutter/material.dart';
import 'package:kissan_garden/presentations/shared/kisaan_button.dart';
import 'package:kissan_garden/utils/Validators.dart';
import 'package:kissan_garden/utils/styles.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
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
                  'Enter your mobile number, we will send you an OPT to verify',
                  textAlign: TextAlign.center,
                  style: Styles.subHeadingText(),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  maxLength: 10,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  validator: Validators.validatePhoneNo,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(2.0),
                      ),
                    ),
                    hintText: 'Enter your 10 digit mobile no.',
                    errorStyle: TextStyle(color: Styles.errorColor),
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
                  'By signing in, you agree to our Terms and Conditions',
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

  _login() {}
}
