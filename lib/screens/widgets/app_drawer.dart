import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_shop_app/screens/order_screen.dart';
import 'package:my_shop_app/screens/products_overview_screen.dart';
import 'package:my_shop_app/screens/user_products_screen.dart';

class AppDrawerWidget extends StatelessWidget {
  const AppDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // flutter navbar in drawer
    return Drawer(
      backgroundColor: Colors.purple.shade100,
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Get.to(ProductsOverviewScreen());
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Get.to(() => OrderScreen());
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit_sharp),
            title: Text('Manage Products'),
            onTap: () {
              Get.to(() => UserProductsScreen());
            },
          )
        ],
      ),
    );
  }
}
