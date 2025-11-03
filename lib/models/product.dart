class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> j) => Product(
    id: j['id'].toString(),
    title: j['title'] ?? '',
    description: j['description'] ?? '',
    price: (j['price'] != null) ? double.tryParse(j['price'].toString()) ?? 0.0 : 0.0,
    image: j['image'] ?? '',
  );
}