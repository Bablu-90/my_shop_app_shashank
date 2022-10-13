import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_shop_app/Getx/orders.dart';
import 'package:my_shop_app/screens/widgets/app_drawer.dart';
import 'package:my_shop_app/screens/widgets/order_item.dart';

import '../Getx/orders.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      OrdersController ordersController = Get.find();
      ordersController.fetchAndSetOrders();
    });
    super.initState();
  }

  final DatabaseReference ref =
      FirebaseDatabase.instance.ref().child('OrderItem');
  @override
  Widget build(BuildContext context) {
    OrdersController orderController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawerWidget(),
      body: Obx(() {
        print(
            "Orders Length: ${orderController.orderItem.value.products.length}");

        return ListView.builder(
          itemCount: orderController.orderItem.value.products.length,
          itemBuilder: (ctx, i) =>
              OrderItemWidget(orderController.orderItem.value),
        );
      }),
      backgroundColor: Colors.purple.shade200,
    );
  }
}
