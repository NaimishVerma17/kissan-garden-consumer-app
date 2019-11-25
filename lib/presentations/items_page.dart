import 'package:flutter/material.dart';
import 'package:kissan_garden/models/category_item.dart';
import 'package:kissan_garden/models/mixins/unsubscribe.dart';
import 'package:kissan_garden/presentations/shared/item_card.dart';
import 'package:kissan_garden/presentations/shared/search_bar.dart';
import 'package:kissan_garden/services/broadcaster_service.dart';
import 'package:kissan_garden/services/product_service.dart';
import 'package:kissan_garden/services/user_service.dart';
import 'package:kissan_garden/utils/route_utils.dart';
import 'package:kissan_garden/utils/styles.dart';

class ItemsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ItemsPage();
  }
}

class _ItemsPage extends State<ItemsPage> with UnsubscribeMixin {
  ProductService _productService = ProductService.getInstance();
  BroadcasterService _broadcasterService = BroadcasterService.getInstance();
  UserService _userService = UserService.getInstance();
  String _id;
  String _title;
  String _keyword;
  bool _isLoading = true;
  List<CategoryItem> _items;
  bool _isItemsLoaded = false;
  bool _isLoggedIn = false;

  @override
  void initState() {
    _broadcasterService
        .on(BroadcasterEventType.loginComplete)
        .takeUntil(distroy$)
        .listen((data) {
      setState(() {
        _isLoading = true;
        _loadUserData();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isItemsLoaded) {
      Map<String, String> _args = ModalRoute.of(context).settings.arguments;
      _id = _args['id'];
      _title = _args['title'];
      _keyword = _args['keyword'];
      _isLoggedIn = _args['is_logged_in'] == 'true' ? true : false;
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
        actions: <Widget>[
          !_isLoggedIn
              ? IconButton(
                  icon: Icon(
                    Icons.person,
                    size: 32.0,
                    color: Styles.primaryColor,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  onPressed: () {
                    Navigator.pushNamed(context, RouteUtils.login);
                  },
                )
              : IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    size: 32.0,
                    color: Styles.primaryColor,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  onPressed: () {
                    Navigator.pushNamed(context, RouteUtils.cart);
                  },
                )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Styles.homeBackgroundColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18.0),
          child: Column(
            children: <Widget>[
              SearchBar(
                initialValue: _keyword,
                search: _searchItems,
              ),
              SizedBox(
                height: 10.0,
              ),
              _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      child: _items.length == 0
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
                            ),
                    ),
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
    _keyword = keyword;
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

  _loadUserData() async {
    await _userService.bootstrapApp();
    setState(() {
      _isLoggedIn = true;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }
}
