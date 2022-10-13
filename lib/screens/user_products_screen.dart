import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_shop_app/Getx/products_getx.dart';
import 'package:my_shop_app/screens/edit_product_screen.dart';
import 'package:my_shop_app/screens/widgets/app_drawer.dart';
import 'package:my_shop_app/screens/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductsGetController productsGetController =
        Get.put(ProductsGetController());
    return Scaffold(
      appBar: AppBar(
        title: Text('\Your Products'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Get.to(() => EditProductScreen());
            },
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ],
      ),
      drawer: AppDrawerWidget(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Obx(() {
          return ListView.builder(
            itemCount: productsGetController.items.length,
            itemBuilder: (_, i) => Column(
              children: [
                UserProductItem(
                  product: productsGetController.items[i],
                ),
                Divider(),
              ],
            ),
          );
        }),
      ),
      backgroundColor: Colors.purpleAccent.shade100,
    );
  }
}
