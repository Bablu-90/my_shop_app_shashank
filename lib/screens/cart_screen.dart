import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_shop_app/Getx/cart.dart';
import 'package:my_shop_app/Getx/orders.dart';
import 'package:my_shop_app/Getx/products_getx.dart';
import 'package:my_shop_app/screens/widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    ProductsGetController productsGetController =
        Get.put(ProductsGetController());
    OrdersController orderController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Obx(() {
                      return Text(
                        productsGetController.shoppingCartItems.isNotEmpty
                            ? '\$${productsGetController.shoppingCartItems.map((element) => element.price).toList().reduce((value, element) => value + element).toStringAsFixed(2)}'
                            : '0.0',
                        style: TextStyle(color: Colors.white),
                      );
                    }),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      orderController.addOrder(
                          [
                            ...productsGetController.shoppingCartItems.map(
                                (element) => CartItem(
                                    id: element.id,
                                    title: element.title,
                                    quantity: 1,
                                    price: element.price))
                          ],
                          productsGetController.shoppingCartItems
                              .map((element) => element.price)
                              .toList()
                              .reduce((value, element) => value + element));
                      Get.snackbar(
                        "Orders",
                        "Orders placed Sucessfully",
                        backgroundColor: Colors.purpleAccent.shade100,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    child: Text('ORDER NOW'),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(child: Obx(() {
            return ListView.builder(
              itemCount: productsGetController.shoppingCartItems.length,
              itemBuilder: (ctx, i) => CartItemWidget(
                  id: productsGetController.shoppingCartItems.value
                      .toList()[i]
                      .id,
                  title: productsGetController.shoppingCartItems.value
                      .toList()[i]
                      .title,
                  quantity: 1,
                  productId:
                      productsGetController.shoppingCartItems.value[i].id,
                  price: productsGetController.shoppingCartItems.value
                      .toList()[i]
                      .price),
            );
          }))
        ],
      ),
      backgroundColor: Colors.purple.shade100,
    );
  }
}
