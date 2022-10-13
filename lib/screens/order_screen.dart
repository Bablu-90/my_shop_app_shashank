import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_shop_app/Getx/orders.dart';
import 'package:my_shop_app/screens/widgets/app_drawer.dart';
import 'package:my_shop_app/screens/widgets/order_item.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      OrdersController ordersController = Get.put(OrdersController());
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
        title: const Text('Your Orders'),
      ),
      drawer: const AppDrawerWidget(),
      body: Obx(() {
        return ListView.builder(
          itemCount: orderController.orderList.length,
          itemBuilder: (ctx, i) =>
              OrderItemWidget(orderController.orderList[i]),
        );
      }),
      backgroundColor: Colors.purple.shade200,
    );
  }
}
