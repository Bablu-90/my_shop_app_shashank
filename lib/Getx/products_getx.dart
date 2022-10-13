import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:my_shop_app/models/product.dart';

class ProductsGetController extends GetxController {
  RxList<Product> items = <Product>[].obs;

  // RxBool _showFavoritesOnly = false.obs;
  RxList<Product> shoppingCartItems = <Product>[].obs;
  RxBool showOnlyFavorites = false.obs;
  RxString title = 'Product Description'.obs;

  Product? findById(String Id) {
    return items[items.indexWhere((prod) => prod.id == Id)];
  }

  Product? get favoriteItems {
    return items[
        items.indexWhere((prodItem) => prodItem.isFavourite == prodItem)];
  }

  /*void showFavoritesOnly() {
    _showFavoritesOnly.value = true;
  }

  void showAll() {
    _showFavoritesOnly.value = false;
  }*/

  Future<void> addProduct(Product product) async {
    await FirebaseDatabase.instance
        .ref()
        .child('Product')
        .child(product.id)
        .set(product.toJson())
        .then((value) {
      //items.add(product);
    });
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    await FirebaseDatabase.instance
        .ref()
        .child('Product')
        .child(newProduct.id)
        .update(newProduct.toJson())
        .then((value) {});
    /*final prodIndex = items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      items[prodIndex] = newProduct;
    } else {
      print('...');
    }*/
  }

  void deleteProduct(String id) async {
    await FirebaseDatabase.instance
        .ref()
        .child('Product')
        .child(id)
        .remove()
        .then((value) {});
    items.removeWhere((prod) => prod.id == id);
  }

  void toggleFavorite(int index) {
    items.replaceRange(index, index + 1, [
      Product(
          id: items[index].id,
          title: items[index].title,
          description: items[index].description,
          price: items[index].price,
          imageUrl: items[index].imageUrl,
          isFavourite: !items[index].isFavourite)
    ]);
  }

  Future<void> fetchAndSetProducts() async {
    await FirebaseDatabase.instance
        .ref()
        .child('Product')
        .onValue
        .listen((event) {
      items.clear();
      event.snapshot.children.forEach((element) {
        Product newProduct =
            Product.fromJson(jsonDecode(jsonEncode(element.value)));
        items.add(newProduct);
      });
    });
  }

  @override
  void onInit() {
    fetchAndSetProducts();
    super.onInit();
  }
}
