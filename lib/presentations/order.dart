import 'package:flutter/material.dart';
import 'package:kissan_garden/models/address.dart';
import 'package:kissan_garden/services/user_service.dart';
import 'package:kissan_garden/utils/styles.dart';

class OrderPage extends StatelessWidget {
  int _addressId;

  final UserService _userService = UserService.getInstance();
  final ScrollController _scrollController = new ScrollController();

  List<Address> _savedAddresses;

  @override
  Widget build(BuildContext context) {
    _savedAddresses = _userService.savedAddresses;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order',
          style: Styles.pageTitleText(),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Styles.primaryColor),
      ),
      body: Column(
        children: <Widget>[
          Text(
            'Select a delivery address',
            style: Styles.headingText(),
          ),
          _getAddressSelectionTiles(),
          Text(
            'Select a time slot',
            style: Styles.headingText(),
          ),
        ],
      ),
    );
  }

  Widget _getAddressSelectionTiles() {
    return ListView.builder(
      controller: _scrollController,
      itemBuilder: (context, index) => Container(
        child: Row(
          children: <Widget>[
            Radio(
              value: _savedAddresses[index].id,
              groupValue: _addressId,
              onChanged: _addressSelected,
            ),
            SizedBox(
              width: 5.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Wrap(
                  alignment: WrapAlignment.start,
                  children: <Widget>[
                    Text('Full Address:', style: Styles.labelText()),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      _savedAddresses[index].fullAddress,
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Wrap(
                  children: <Widget>[
                    Text('City:', style: Styles.labelText()),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      _savedAddresses[index].city,
                      style: TextStyle(fontSize: 15.0),
                    )
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Wrap(
                  children: <Widget>[
                    Text('Pincode:', style: Styles.labelText()),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      _savedAddresses[index].pinCode,
                      style: TextStyle(fontSize: 15.0),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addressSelected(int value) {
    _addressId = value;
  }
}
