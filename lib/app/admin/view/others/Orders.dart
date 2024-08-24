class Order {
  final String orderId;
  final String userId;
  final String productId;
  final String productName;
  final String productDescription;
  final String productPrice;
  final String pdImageUrl;
  final String sellerId;

  Order({
    required this.orderId,
    required this.userId,
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.pdImageUrl,
    required this.sellerId,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'],
      userId: json['userId'],
      productId: json['productId'],
      productName: json['productName'],
      productDescription: json['productDescription'],
      productPrice: json['productPrice'],
      pdImageUrl: json['pdImageUrl'],
      sellerId: json['sellerId'],
    );
  }
}
