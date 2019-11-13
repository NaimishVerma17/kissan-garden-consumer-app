import 'package:flutter/material.dart';
import 'package:kissan_garden/models/address.dart';
import 'package:kissan_garden/models/mixins/unsubscribe.dart';
import 'package:kissan_garden/presentations/popups/add_address.dart';
import 'package:kissan_garden/presentations/shared/saved_address_card.dart';
import 'package:kissan_garden/services/broadcaster_service.dart';
import 'package:kissan_garden/services/user_service.dart';
import 'package:kissan_garden/utils/styles.dart';

class SavedAddressesPage extends StatefulWidget {
  @override
  _SavedAddressesPage createState() => _SavedAddressesPage();
}

class _SavedAddressesPage extends State<SavedAddressesPage>
    with UnsubscribeMixin {
  List<Address> _savedAddresses = new List();

  UserService _userService = UserService.getInstance();

  BroadcasterService _broadcasterService = BroadcasterService.getInstance();

  @override
  void initState() {
    _savedAddresses = _userService.savedAddresses;
    _broadcasterService
        .on(BroadcasterEventType.addressChanged)
        .takeUntil(distroy$)
        .listen((data) {
      if (this.mounted) {
        setState(() {
          print('address changed');
          _savedAddresses = data;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Delivery Addresses',
          style: Styles.pageTitleText(),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Styles.primaryColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          children: <Widget>[
            Container(
              width: _width,
              height: 54.0,
              child: FlatButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AddAddressPage(),
                  );
                },
                color: Styles.textBackgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add_circle_outline,
                      color: Styles.linkColor,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'ADD NEW ADDRESS',
                      style: TextStyle(color: Styles.linkColor, fontSize: 16.0),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ListView.builder(
                  itemCount: _savedAddresses.length,
                  itemBuilder: (context, index) => GestureDetector(
                      child: SavedAddressCard(
                          _savedAddresses[index], _addressClicked)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    this.onDispose();
    super.dispose();
  }

  void _addressClicked(Address a) {
    showDialog(
        context: context, builder: (context) => AddAddressPage(address: a));
  }
}
