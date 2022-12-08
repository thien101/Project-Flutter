class Product {
  int? id;
  String title;
  int price;
  String category;
  String image;
  int sl;

  Product({
    this.id,
    required this.title,
    required this.category,
    required this.image,
    required this.sl,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        title: json['title'],
        price: json['price'],
        category: json['category'],
        image: json['image'],
        sl: json['sl'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'category': category,
        'image': image,
        'sl': sl,
      };
}
