class Order {
  final String id;
  final String userId;
  final String productId;
  final String productName;
  final String productPrice;
  final String pdImageUrl;
  final String sellerId;
  final String userEmail;
  final String productDescription;
  final String orderDate ;

  Order({
    required this.id,
    required this.userId,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.pdImageUrl,
    required this.sellerId,
    required this.userEmail,
    required this.productDescription,
    required this.orderDate
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['user_id'],
      productId: json['product_id'],
      productName: json['product_name'],
      productPrice: json['product_price'],
      pdImageUrl: json['pd_image_url'],
      sellerId: json['seller_id'],
      userEmail: json['user_email'],
      productDescription: json['product_description'],
      orderDate: json['order_date']
    );
  }
}
