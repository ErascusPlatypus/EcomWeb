class likedProduct {
  int lid;
  int pid;
  String imageUrl;
  String name;
  String description;
  double price;
  int categoryId;
  int sellerId;
  double gst;
  String emailId;

  likedProduct({
    required this.lid,
   required this.pid,
   required this.imageUrl,
   required this.name,
   required this.description,
   required this.price,
   required this.categoryId,
   required this.sellerId,
   required this.gst,
   required this.emailId,
  });

  factory likedProduct.fromJson(Map<String, dynamic> json) {
    return likedProduct(
      lid: int.parse(json['lid']),
      pid: int.parse(json['pid']),
      imageUrl: json['imageurl'],
      name: json['name'],
      description: json['description'],
      price: double.parse(json['price']), // Convert to double
      categoryId: int.parse(json['categoryid']),
      sellerId: int.parse(json['seller_id']),
      gst: double.parse(json['gst']), // Convert to double
      emailId: json['email_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lid'] = this.lid;
    data['pid'] = this.pid;
    data['imageurl'] = this.imageUrl;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['categoryid'] = this.categoryId;
    data['seller_id'] = this.sellerId;
    data['gst'] = this.gst;
    data['email_id'] = this.emailId;
    return data;
  }
}
