import 'package:flutter/material.dart';
import 'package:kissan_garden/models/user.dart';
import 'package:kissan_garden/services/user_service.dart';
import 'package:kissan_garden/utils/Validators.dart';
import 'package:kissan_garden/utils/styles.dart';

class MyAccountPage extends StatefulWidget {
  @override
  _MyAccountPage createState() => _MyAccountPage();
}

class _MyAccountPage extends State<MyAccountPage> {
  UserService _userService = UserService.getInstance();
  GlobalKey<FormState> _globalKey = GlobalKey();
  TextEditingController _editingController = TextEditingController();
  User _user;
  String _name;
  bool _isLoading = false;

  @override
  void initState() {
    _user = _userService.user;
    _editingController.value = TextEditingValue(text: _user.fullName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Account',
          style: Styles.pageTitleText(),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Styles.primaryColor),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: 200.0,
        padding: EdgeInsets.all(5.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'User details',
                    style: Styles.headingText(),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: TextFormField(
                          decoration: InputDecoration(hintText: 'Full name'),
                          controller: _editingController,
                          validator: Validators.validateForNull,
                          onSaved: (value) {
                            _name = value;
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: _isLoading
                            ? CircularProgressIndicator()
                            : IconButton(
                                icon: Icon(
                                  Icons.check_circle,
                                  size: 40.0,
                                  color: Styles.primaryColor,
                                ),
                                onPressed: _updateName,
                              ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Wrap(
                    children: <Widget>[
                      Text('Phone No:', style: Styles.labelText()),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        _user.phoneNumber,
                        style: TextStyle(fontSize: 15.0),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _updateName() async {
    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await _userService.updateUser(_name);
        setState(() {
          _isLoading = false;
        });
        Styles.showToast('Name updates successfully.');
      } catch (error) {
        Styles.showToast(error);
      }
    }
  }
}
