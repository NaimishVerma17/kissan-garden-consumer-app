import 'package:flutter/material.dart';
import 'package:kissan_garden/models/address.dart';
import 'package:kissan_garden/services/user_service.dart';
import 'package:kissan_garden/utils/Validators.dart';
import 'package:kissan_garden/utils/styles.dart';

class AddAddressPage extends StatefulWidget {
  Address address;

  AddAddressPage({this.address});

  @override
  State createState() => _AddAddressPage(address);
}

class _AddAddressPage extends State<AddAddressPage> {
  Address _address;

  _AddAddressPage(this._address);

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
            _address != null ? 'Update' : 'Add',
            style: TextStyle(
              fontSize: 16.0,
              color: Styles.primaryColor,
            ),
          ),
          onPressed: !_isLoading ? _addAddress : null,
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
            if (!_isLoading) Navigator.of(context).pop();
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
                initialValue: _address != null ? _address.fullAddress : null,
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
                initialValue: _address != null ? _address.city : null,
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
                initialValue: _address != null ? _address.pinCode : null,
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
        if (_address == null) {
          await _userService.addAddress(_data);
        } else {
          await _userService.updateAddress(_data, _address.id);
        }
        _isLoading = false;
        Navigator.of(context).pop();
      } catch (error) {
        Styles.showToast(error.toString());
        _isLoading = false;
      }
    }
  }
}
