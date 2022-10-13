import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Get.to(() => const EditProductScreen());
            },
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ],
      ),
      drawer: const AppDrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Obx(() {
          return ListView.builder(
            itemCount: productsGetController.items.length,
            itemBuilder: (_, i) => Column(
              children: [
                UserProductItem(
                  product: productsGetController.items[i],
                ),
                const Divider(),
              ],
            ),
          );
        }),
      ),
      backgroundColor: Colors.purpleAccent.shade100,
    );
  }
}
