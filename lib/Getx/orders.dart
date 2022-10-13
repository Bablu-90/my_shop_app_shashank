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
        amount: double.parse(json['amount'].toString()),
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
  RxList<OrderItem> orderList = RxList<OrderItem>([]);

  Future<void> fetchAndSetOrders() async {
    FirebaseDatabase.instance.ref().child('OrderItem').onValue.listen((event) {
      ProductsGetController productsGetController =
          Get.put(ProductsGetController());
      productsGetController.shoppingCartItems.clear();
      for (var element in event.snapshot.children) {
        OrderItem orderItem =
            OrderItem.fromJson(jsonDecode(jsonEncode(element.value)));
        orderList.add(orderItem);
      }
    });
  }

  @override
  void onInit() {
    fetchAndSetOrders();
    super.onInit();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();
    await FirebaseDatabase.instance
        .ref()
        .child('OrderItem')
        .child(orderId)
        .set(OrderItem(
                id: orderId,
                amount: cartProducts.isNotEmpty
                    ? cartProducts
                        .map((e) => e.price)
                        .toList()
                        .reduce((value, element) => value + element)
                    : 0,
                products: cartProducts,
                dateTime: DateTime.now())
            .toJson())
        .then((value) => {});
  }
}
