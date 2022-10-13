import 'package:get/get.dart';
import 'package:my_shop_app/Getx/products_getx.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      title: json['title'],
      quantity: json['quantity'],
      price: double.parse(json['price']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'quantity': quantity, 'price': price};
  }
}

class CartController extends GetxController {
  ProductsGetController productsGetController =
      Get.put(ProductsGetController());

  RxMap<String, CartItem> items = <String, CartItem>{}.obs;

  int get itemCount {
    return items.length;
  }

  double get totalAmount {
    return items.values
        .map((e) => e.price)
        .toList()
        .reduce((value, element) => value + element);
  }

  void addItem(String productId, double price, String title, int quantity) {
    if (items.containsKey(productId)) {
      items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity + 1,
              price: existingCartItem.price));
    } else {
      items.putIfAbsent(
        productId,
        () => CartItem(
            id: DateTime.now().toString(),
            title: title,
            quantity: 1,
            price: price),
      );
    }
  }

  void removeItem(String productId) {
    items.remove(productId);
  }

  void removeSingleItem(String productId) {
    if (!items.containsKey(productId)) {
      return;
    }
    if (items[productId]!.quantity > 1) {
      items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity - 1,
              price: existingCartItem.price));
    } else {
      items.remove(productId);
    }
  }

  void clear() {
    items == {};
  }
}
