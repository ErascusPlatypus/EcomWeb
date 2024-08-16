class ratingsAndReviews {
  int id;
  int pid;
  String userEmail;
  double rating;
  String review;
  int likes;

  ratingsAndReviews({
    required this.id,
    required this.pid,
    required this.userEmail,
    required this.rating,
    required this.review,
    required this.likes,
  });

  factory ratingsAndReviews.fromJson(Map<String, dynamic> json) {
    return ratingsAndReviews(
      id: int.parse(json['id']),
      pid: int.parse(json['product_id']),
      userEmail: json['user_email'],
      rating: double.parse(json['rating']),
      review: json['review'],
      likes: int.parse(json['price']), // Convert to double
      
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    
    data['product_id'] = this.pid;
    data['user_email'] = this.userEmail;
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['likes'] = this.likes;
    
    return data;
  }
}
