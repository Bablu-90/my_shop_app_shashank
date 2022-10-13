import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_shop_app/Getx/products_getx.dart';
import 'package:my_shop_app/screens/edit_product_screen.dart';

import '../../models/product.dart';

class UserProductItem extends StatelessWidget {
  final Product product;

  const UserProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    _showDeleteDialog({required Product product, required String id}) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.deepPurple.shade200,
              title: Text('Delete ${product.id}'),
              content: const Text(
                'Are you sure you want to delete?',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: Colors.black87),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700))),
                TextButton(
                    onPressed: () {
                      ProductsGetController productsgetcontroller = Get.find();
                      productsgetcontroller.deleteProduct(product.id);
                      FirebaseDatabase.instance
                          .ref()
                          .child('Product')
                          .child(id)
                          .remove()
                          .whenComplete(() {
                        Navigator.pop(context);
                      });
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ))
              ],
            );
          });
    }

    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                Get.to(() => EditProductScreen(
                      id: product.id,
                    ));
              },
              color: Theme.of(context).primaryColor,
              icon: const Icon(Icons.edit, color: Colors.black),
            ),
            IconButton(
              onPressed: () {
                _showDeleteDialog(product: product, id: product.id);
              },
              color: Theme.of(context).errorColor,
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
