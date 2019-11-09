import 'package:flutter/material.dart';
import 'package:kissan_garden/models/address.dart';
import 'package:kissan_garden/presentations/shared/kisaan_button.dart';
import 'package:kissan_garden/utils/Validators.dart';
import 'package:kissan_garden/utils/styles.dart';

class AddAddressPage extends StatefulWidget {
  @override
  State createState() => _AddAddressPage();
}

class _AddAddressPage extends State<AddAddressPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey();
  String _fullAddress;
  String _city;
  String _pinCode;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Address',
          style: Styles.pageTitleText(),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Styles.primaryColor),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  maxLength: 10,
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
                  height: 12.0,
                ),
                KisaanButton(
                  text: 'Add address',
                  onClick: _isLoading ? null : _addAddress,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _addAddress() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Address _address = Address(_fullAddress, _city, _pinCode);
    }
  }
}
