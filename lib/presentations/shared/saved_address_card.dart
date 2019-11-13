import 'package:flutter/material.dart';
import 'package:kissan_garden/models/address.dart';
import 'package:kissan_garden/utils/styles.dart';

class SavedAddressCard extends StatelessWidget {
  Address address;
  Function onClick;

  SavedAddressCard(this.address, this.onClick);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => this.onClick(address),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                    address.fullAddress,
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
                    address.city,
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
                    address.pinCode,
                    style: TextStyle(fontSize: 15.0),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
