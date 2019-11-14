import 'package:flutter/material.dart';
import 'package:kissan_garden/utils/styles.dart';

class SearchBar extends StatelessWidget {
  String initialValue;
  Function search;

  TextEditingController _controller;

  SearchBar({this.initialValue, this.search}) {
    _controller = new TextEditingController();
    if (this.initialValue != null) {
      _controller.value = TextEditingValue(text: initialValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(),
      alignment: Alignment.center,
      height: 48.0,
      decoration: new BoxDecoration(
        color: Colors.white,
        border: new Border.all(color: Colors.white, width: 4.0),
        borderRadius: new BorderRadius.circular(20.0),
      ),
      child: new TextField(
        onSubmitted: (value) => search(value),
        controller: _controller,
        textInputAction: TextInputAction.search,
        style: TextStyle(fontSize: 16.0),
        decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(
              Icons.search,
              size: 25.0,
              color: Styles.primaryColor,
            ),
            border: InputBorder.none),
      ),
    );
  }
}
