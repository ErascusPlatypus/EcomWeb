class Product {
  final int pid;
  final String imgUrl;
  final String name;
  final String description;
  final double price;
  final int categoryId;
  final int sellerId;
  final double gst;

  Product( {required this.pid,
    required this.imgUrl,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.sellerId,
    required this.gst,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      pid:json['pid'],
      imgUrl: json['imgurl'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      categoryId: json['category_id'],
      sellerId: json['seller_id'],
      gst: json['gst'].toDouble(),
    );
  }
}
