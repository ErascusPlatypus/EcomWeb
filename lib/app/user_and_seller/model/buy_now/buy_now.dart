class BuyNow {
  int? id;
  int? user_id;
  int? product_id;
  String? product_name;
  String? product_price;
  String? pd_image_url;
  int? seller_id;
  String? user_email;
  String? product_description;

  BuyNow({
    this.id,
    this.user_id,
    this.product_id,
    this.product_name,
    this.product_price,
    this.pd_image_url,
    this.seller_id,
    this.user_email,
    this.product_description,
  });

  factory BuyNow.fromJson(Map<String, dynamic> json) => BuyNow(
        id: int.parse(json['id']),
        user_id: int.parse(json['user_id']),
        product_id: int.parse(json['product_id']),
        product_name: json['product_name'],
        product_price: json['product_price'],
        pd_image_url: json['pd_image_url'],
        seller_id: int.parse(json['seller_id']),
        user_email: json['user_email'],
        product_description: json['product_description'],
      );
}
