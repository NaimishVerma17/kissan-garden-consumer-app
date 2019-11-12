import 'package:flutter/material.dart';
import 'package:kissan_garden/presentations/shared/kisaan_button.dart';
import 'package:kissan_garden/services/user_service.dart';
import 'package:kissan_garden/utils/Validators.dart';
import 'package:kissan_garden/utils/styles.dart';

class AddAddressPage extends StatefulWidget {
  @override
  State createState() => _AddAddressPage();
}

class _AddAddressPage extends State<AddAddressPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey();
  final UserService _userService = UserService.getInstance();
  String _fullAddress;
  String _city;
  String _pinCode;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        FlatButton(
          child: Text(
            'Add',
            style: TextStyle(
              fontSize: 16.0,
              color: Styles.primaryColor,
            ),
          ),
          onPressed: _addAddress,
        ),
        FlatButton(
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: 16.0,
              color: Styles.errorColor,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                maxLines: 4,
                keyboardType: TextInputType.text,
                validator: Validators.validateForNull,
                decoration: Styles.getInputDecoration('Full address'),
                onSaved: (value) {
                  _fullAddress = value;
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                maxLength: 10,
                keyboardType: TextInputType.text,
                validator: Validators.validateForNull,
                decoration: Styles.getInputDecoration('City'),
                onSaved: (value) {
                  _city = value;
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                maxLength: 6,
                keyboardType: TextInputType.number,
                validator: Validators.validatePinCode,
                decoration: Styles.getInputDecoration('Pincode'),
                onSaved: (value) {
                  _pinCode = value.toString();
                },
              ),
              SizedBox(
                height: 5.0,
              ),
              _isLoading ? CircularProgressIndicator() : Container()
            ],
          ),
        ),
      ),
    );
  }

  _addAddress() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('add address');
      setState(() {
        _isLoading = true;
      });
      final Map<String, String> _data = {
        'full_address': _fullAddress,
        'city': _city,
        'pin_code': _pinCode
      };
      try {
        await _userService.addAddress(_data);
        _isLoading = false;
        Navigator.of(context).pop();
      } catch (error) {
        Styles.showToast(error.toString());
        _isLoading = false;
      }
    }
  }
}
