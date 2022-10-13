import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_shop_app/Getx/products_getx.dart';

import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final ProductsGetController controller = Get.put(ProductsGetController());
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(controller.findById(product.id) != null
              ? controller.findById(product.id)!.title
              : 'Product Description'),
        ),
        backgroundColor: Colors.blue.shade200,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: const Color(0xffF6F6F6),
              height: 300,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '\$${product.price}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                product.description,
                textAlign: TextAlign.center,
                softWrap: true,
                style: const TextStyle(
                  color: Color(0xff405D52),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
