class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final bool isFavourite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.isFavourite,
  });

  //from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: double.parse(json['price'].toString()),
      imageUrl: json['imageUrl'],
      isFavourite: json['isFavourite'],
    );
  }

  //to JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
        'isFavourite': isFavourite,
      };

  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? imageUrl,
    bool? isFavourite ,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}

//1. Widget class (extends statefulWidget)
//2. Model Class (this one)
//3. Controller class (extends GetxController) (login_page_get_controller)
