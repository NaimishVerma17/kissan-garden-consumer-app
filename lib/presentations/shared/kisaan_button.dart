import 'package:flutter/material.dart';
import 'package:kissan_garden/utils/styles.dart';

class KisaanButton extends StatelessWidget {
  final String text;
  final Function onClick;

  KisaanButton({@required this.text, @required this.onClick}) {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onClick,
      child: Container(
        decoration: BoxDecoration(
          color: Styles.primaryColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Styles.subHeadingColor,
              blurRadius: 5.0,
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        height: 45.0,
        alignment: Alignment(0.0, 0.0),
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 3.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}
