import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_shop_app/Getx/products_getx.dart';
import 'package:my_shop_app/screens/cart_screen.dart';
import 'package:my_shop_app/screens/widgets/app_drawer.dart';
import 'package:my_shop_app/screens/widgets/badge.dart';
import 'package:my_shop_app/screens/widgets/product_grid.dart';

import '../Getx/cart.dart';
import '../Getx/orders.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _isInit = true;
  RxBool _isLoading = false.obs;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isLoading.value = true;
      ProductsGetController productsGetController = Get.find();
      productsGetController.fetchAndSetProducts().then((_) {
        Future.delayed(Duration(seconds: 2), () {
          _isLoading.value = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  final ProductsGetController productsGetController =
      Get.put(ProductsGetController());
  final CartController cartController = Get.put(CartController());
  OrdersController orderController = Get.put(OrdersController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              if (selectedValue == FilterOptions.Favorites) {
                productsGetController.showOnlyFavorites.value = true;
              } else {
                productsGetController.showOnlyFavorites.value = false;
              }
              print(selectedValue);
            },
            icon: Icon(
              Icons.more_vert_sharp,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text('Only Favorites'),
                  value: FilterOptions.Favorites),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Obx(() {
            return Badge(
                child: IconButton(
                    onPressed: () {
                      Get.to(() => CartScreen());
                    },
                    icon: Icon(Icons.shopping_cart)),
                value:
                    productsGetController.shoppingCartItems.length.toString(),
                color: Colors.deepOrangeAccent.shade200);
          })
        ],
      ),
      drawer: AppDrawerWidget(),
      body: Obx(() {
        return _isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                    color: Colors.black87, backgroundColor: Colors.deepPurple),
              )
            : ProductGrid();
      }),
      backgroundColor: Colors.purple.shade200,
    );
  }
}
