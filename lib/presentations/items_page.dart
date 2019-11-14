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
  String _keyword;
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
      _keyword = _args['keyword'];
      _fetchItems();
      _isItemsLoaded = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_title != null ? _title : 'Items',
            style: Styles.pageTitleText()),
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
                    SearchBar(
                      search: _searchItems,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    _items.length == 0
                        ? Center(
                            child: Text(
                              'Sorry, It seems no product exist with this name!',
                              style: Styles.labelText(),
                            ),
                          )
                        : Expanded(
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
      if (_id != null) {
        _items = await _productService.fetchItems(id: _id);
      }
      if (_keyword != null) {
        _items = await _productService.fetchItems(keyword: _keyword);
      }
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

  _searchItems(String keyword) async {
    try {
      setState(() {
        _isLoading = true;
      });
      _items = await _productService.fetchItems(keyword: _keyword);
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
