import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_shop_app/Getx/cart.dart';
import 'package:my_shop_app/screens/product_detail_screen.dart';

import '../../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  final Function() favoriteClicked;
  final Function() cartClicked;

  const ProductItem(
      {super.key,
      required this.product,
      required this.favoriteClicked,
      required this.cartClicked});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: GridTileBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
          onPressed: () {
            favoriteClicked();
          },
          icon: Icon(product.isFavourite
              ? Icons.favorite
              : Icons.favorite_border_outlined),
          color: Theme.of(context).accentColor,
        ),
        title: Text(
          product.title,
          textAlign: TextAlign.center,
        ),
        trailing: IconButton(
            onPressed: () {
              cartClicked();
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.purpleAccent.shade400,
                  content: Text('Added Item to cart!'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                      label: 'UNDO',
                      textColor: Colors.black,
                      onPressed: () {
                        CartController cartController =
                            Get.put(CartController());
                        cartController.removeSingleItem(product.id);
                      }),
                ),
              );
            },
            color: Theme.of(context).accentColor,
            icon: Icon(Icons.shopping_cart)),
      ),
      child: GestureDetector(
        onTap: () {
          Get.to(() => ProductDetailScreen(product: product));
          /*Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return ProductDetailScreen(productId: product.id);
          }));*/
        },
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: product.imageUrl,
        ),
      ),
    );
  }
}
