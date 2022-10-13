import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:my_shop_app/Getx/products_getx.dart';

import 'cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});

//from JSON
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
        id: json['id'],
        amount: json['amount'],
        products: (json['products'] as List<dynamic>)
            .map((e) => CartItem.fromJson(e))
            .toList(),
        dateTime: DateTime.parse(json['dateTime']));
  }
//to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'products': products.map((e) => e.toJson()).toList(),
      'dateTime': dateTime.toIso8601String()
    };
  }
}

class OrdersController extends GetxController {
  Rx<OrderItem> orderItem = OrderItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          amount: 3,
          products: [],
          dateTime: DateTime.now())
      .obs;

  Future<void> fetchAndSetOrders() async {
    await FirebaseDatabase.instance
        .ref()
        .child('OrderItem')
        .onValue
        .listen((event) {
      ProductsGetController productsGetController =
          Get.put(ProductsGetController());
      productsGetController.shoppingCartItems.clear();
      event.snapshot.children.forEach((element) {
        OrderItem orderItem =
            OrderItem.fromJson(jsonDecode(jsonEncode(element.value)));
        orderItem.products.add(CartItem(
            id: orderItem.id,
            title: orderItem.title,
            quantity: orderItem.quantity,
            price: orderItem.price));
      });
    });
  }

  @override
  void onInit() {
    fetchAndSetOrders();
    super.onInit();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    await FirebaseDatabase.instance
        .ref()
        .child('OrderItem')
        .child(DateTime.now().millisecondsSinceEpoch.toString())
        .set(orderItem.value.toJson())
        .then((value) => {});
    orderItem.value = OrderItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now());
    /*ProductsGetController productsGetController =
        Get.put(ProductsGetController());
    productsGetController.shoppingCartItems.clear();*/
  }
}
