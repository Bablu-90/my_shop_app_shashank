import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_shop_app/Getx/cart.dart';
import 'package:my_shop_app/Getx/products_getx.dart';
import 'package:my_shop_app/screens/widgets/product_item.dart';

class ProductGrid extends StatelessWidget {
  final ProductsGetController productsGetController =
      Get.put(ProductsGetController());

  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          padding: const EdgeInsets.all(10.0),
          itemCount: productsGetController.items.length,
          itemBuilder: (ctx, i) {
            return Obx(() {
              return Visibility(
                visible: (productsGetController.showOnlyFavorites.value &&
                        productsGetController.items[i].isFavourite) ||
                    !productsGetController.showOnlyFavorites.value,
                child: ProductItem(
                  product: productsGetController.items[i],
                  favoriteClicked: () {
                    productsGetController.toggleFavorite(i);
                  },
                  cartClicked: () {
                    if (productsGetController.shoppingCartItems.any((element) =>
                        element.id == productsGetController.items[i].id)) {
                      productsGetController.shoppingCartItems.removeWhere(
                          (element) =>
                              element.id == productsGetController.items[i].id);
                    } else {
                      productsGetController.shoppingCartItems
                          .add(productsGetController.items[i]);
                    }
                  },
                ),
              );
            });
          });
    });
  }
}
