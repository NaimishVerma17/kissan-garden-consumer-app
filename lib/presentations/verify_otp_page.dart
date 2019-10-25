import 'package:flutter/material.dart';
import 'package:kissan_garden/presentations/shared/kisaan_button.dart';
import 'package:kissan_garden/utils/Validators.dart';
import 'package:kissan_garden/utils/styles.dart';

class VerifyOtpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VerifyOtpPage();
  }
}

class _VerifyOtpPage extends State<VerifyOtpPage> {
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
                  'Verify OTP',
                  style: Styles.headingText(),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Form(
                  key: _globalKey,
                  child: TextFormField(
                    maxLength: 10,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    validator: Validators.validatePhoneNo,
                    decoration: Styles.getInputDecoration(
                        'Enter 6 digit OTP sent on your mobile no.'),
                    onSaved: (value) {
                      _phoneNo = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                KisaanButton(
                  text: 'Verify OTP',
                  onClick: _verifyOtp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _verifyOtp() {
    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      print(_phoneNo);
    }
    ;
  }
}
