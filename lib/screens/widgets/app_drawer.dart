import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            title: const Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () {
              Get.to(ProductsOverviewScreen());
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: () {
              Get.to(() => const OrderScreen());
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit_sharp),
            title: const Text('Manage Products'),
            onTap: () {
              Get.to(() => const UserProductsScreen());
            },
          )
        ],
      ),
    );
  }
}
