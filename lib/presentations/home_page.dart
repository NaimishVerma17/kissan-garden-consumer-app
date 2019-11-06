import 'package:flutter/material.dart';
import 'package:kissan_garden/models/category.dart';
import 'package:kissan_garden/models/mixins/unsubscribe.dart';
import 'package:kissan_garden/presentations/shared/category_card.dart';
import 'package:kissan_garden/presentations/shared/drawer.dart';
import 'package:kissan_garden/presentations/shared/search_bar.dart';
import 'package:kissan_garden/services/broadcaster_service.dart';
import 'package:kissan_garden/services/product_service.dart';
import 'package:kissan_garden/services/user_service.dart';
import 'package:kissan_garden/utils/route_utils.dart';
import 'package:kissan_garden/utils/styles.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> with UnsubscribeMixin {
  BroadcasterService _broadcasterService = BroadcasterService.getInstance();
  ProductService _productService = ProductService.getInstance();
  UserService _userService = UserService.getInstance();
  bool _isLoggedIn = false;
  bool _isLoading = true;
  List<Category> _categories;
  int _count = 0;

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
    _broadcasterService
        .on(BroadcasterEventType.logout)
        .takeUntil(distroy$)
        .listen((data) {
      setState(() {
        _isLoggedIn = false;
      });
    });
    _fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_count == 0) {
      _isLoggedIn = ModalRoute.of(context).settings.arguments;
      _count += 1;
    }
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
              icon: Icon(
                Icons.menu,
                size: 30.0,
                color: Styles.primaryColor,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }),
        ),
        title: Text('Kissan Garden', style: Styles.pageTitleText()),
        elevation: 0.0,
        backgroundColor: Colors.white,
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
                          itemCount: _categories.length,
                          itemBuilder: (context, index) {
                            return CategoryCard(
                                _categories[index], _navigateToCategory);
                          }),
                    )
                  ],
                ),
              ),
            ),
      drawer: KisaanDrawer(_isLoggedIn),
    );
  }

  _fetchCategories() async {
    try {
      _categories = await _productService.fetchCategories();
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

  _navigateToCategory(int id, String title) {
    Navigator.pushNamed(context, RouteUtils.items,
        arguments: {'title': title, 'id': id.toString()});
  }

  _loadUserData() async {
    await _userService.fetchCart();
    await _userService.fetchConfiguration();
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
