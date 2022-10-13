import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Getx/cart.dart';
import '../../Getx/products_getx.dart';

class CartItemWidget extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  const CartItemWidget(
      {required this.id,
      required this.productId,
      required this.price,
      required this.quantity,
      required this.title});

  @override
  Widget build(BuildContext context) {
    ProductsGetController productsGetController =
        Get.put(ProductsGetController());
    final CartController cartController = Get.put(CartController());
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete_forever,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Are You Sure?'),
            content:
                const Text('Do you want to remove the item from the cart?'),
            actions: <Widget>[
              FloatingActionButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  }),
              FloatingActionButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  }),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        productsGetController.shoppingCartItems
            .removeWhere((element) => element.id == productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(child: Text('\$$price')),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${(price * quantity)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
