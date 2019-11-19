import 'package:flutter/material.dart';
import 'package:kissan_garden/models/address.dart';
import 'package:kissan_garden/models/order.dart';
import 'package:kissan_garden/services/user_service.dart';
import 'package:kissan_garden/utils/route_utils.dart';
import 'package:kissan_garden/utils/styles.dart';

class OrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderPage();
  }
}

class _OrderPage extends State<OrderPage> {
  int _addressId;
  String _deliveryTimeSlot;

  final UserService _userService = UserService.getInstance();

  List<Address> _savedAddresses;
  List<String> _timeSlots;

  @override
  Widget build(BuildContext context) {
    _savedAddresses = _userService.savedAddresses;
    _timeSlots = _userService.config.deliveryTime;
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              _getAddressSelectionTiles(),
              _getTimeSlotTiles(context),
              _getOrderButton()
            ]),
          )
        ],
      ),
    );
  }

  Widget _getAddressSelectionTiles() {
    final double _width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
          child: Text(
            'Select delivery address',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Container(
          width: _width,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: FlatButton(
            color: Styles.primaryColor,
            child: Text(
              'ADD/EDIT SAVED ADDRESSES',
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
            onPressed: () {
              _addEditSavedAddresses();
            },
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        ListView.builder(
          itemCount: _savedAddresses.length,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (context, index) => Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Radio(
                    value: _savedAddresses[index].id,
                    groupValue: _addressId,
                    onChanged: _addressSelected,
                    activeColor: Styles.primaryColor,
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
                            style: TextStyle(fontSize: 16.0),
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
                            style: TextStyle(fontSize: 16.0),
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
                            style: TextStyle(fontSize: 16.0),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Divider(
                thickness: 0.5,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _getTimeSlotTiles(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            'Select time slot',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        ListView.builder(
          itemCount: _timeSlots.length,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (context, index) => ListTile(
            leading: Radio(
              activeColor: Styles.primaryColor,
              value: _timeSlots[index],
              groupValue: _deliveryTimeSlot,
              onChanged: _timeSlotSelected,
            ),
            title: Text(
              _timeSlots[index],
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        )
      ],
    );
  }

  Widget _getOrderButton() {
    final double _width = MediaQuery.of(context).size.width;
    return Container(
      width: _width,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: FlatButton(
        color: Styles.primaryColor,
        child: Text(
          'PLACE ORDER',
          style: TextStyle(color: Colors.white, fontSize: 15.0),
        ),
        onPressed: _placeOrder,
      ),
    );
  }

  void _addressSelected(int value) {
    setState(() {
      _addressId = value;
    });
  }

  void _timeSlotSelected(String value) {
    setState(() {
      _deliveryTimeSlot = value;
    });
  }

  void _addEditSavedAddresses() {
    Navigator.of(context).pushNamed(RouteUtils.savedAddresses);
  }

  void _placeOrder() async {
    if (_addressId == null) {
      Styles.showToast('Please select a delivery address');
      return;
    }

    if (_deliveryTimeSlot == null) {
      Styles.showToast('Please select a time slot');
      return;
    }
    Address address = _savedAddresses.firstWhere((s) => s.id == _addressId,
        orElse: () => null);
    if (address == null) {
      return;
    }
    String _fullAddress = address.fullAddress +
        ', City: ' +
        address.city +
        ', PinCode: ' +
        address.pinCode;
    try {
      Order order = await this._userService.createOrder(
          {'full_address': _fullAddress, 'delivery_time': _deliveryTimeSlot});
      Navigator.pushReplacementNamed(context, RouteUtils.singleOrder, arguments: {'order': order, 'is_new': false});
    } catch (error) {
      Styles.showToast(error);
    }
  }
}
