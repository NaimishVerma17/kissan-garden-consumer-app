import 'package:flutter/material.dart';
import 'package:kissan_garden/models/category_item.dart';
import 'package:kissan_garden/presentations/shared/item_card.dart';
import 'package:kissan_garden/presentations/shared/search_bar.dart';
import 'package:kissan_garden/services/product_service.dart';
import 'package:kissan_garden/utils/styles.dart';

class ItemsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ItemsPage();
  }
}

class _ItemsPage extends State<ItemsPage> {
  String _id;
  String _title;
  bool _isLoading = true;
  ProductService _productService = ProductService.getInstance();
  List<CategoryItem> _items;
  bool _isItemsLoaded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isItemsLoaded) {
      Map<String, String> _args = ModalRoute.of(context).settings.arguments;
      _id = _args['id'];
      _title = _args['title'];
      _fetchItems();
      _isItemsLoaded = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_title, style: Styles.pageTitleText()),
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Styles.primaryColor),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              decoration: BoxDecoration(color: Styles.homeBackgroundColor),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 18.0),
                child: Column(
                  children: <Widget>[
                    SearchBar(),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: _items.length,
                          itemBuilder: (context, index) {
                            return ItemCard(
                              _items[index],
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  _fetchItems() async {
    try {
      _items = await _productService.fetchItems(id: _id);
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      Styles.showToast(error);
      setState(() {
        _isLoading = false;
      });
    }
  }
}
