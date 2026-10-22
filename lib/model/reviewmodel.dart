class Review {
  final String id;
  final String productId;
  final String userName;
  final double rating;
  final String review;
  final String date;
  final bool verifiedPurchase;

  Review({
    required this.id,
    required this.productId,
    required this.userName,
    required this.rating,
    required this.review,
    required this.date,
    this.verifiedPurchase = false,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      productId: json['productId'],
      userName: json['userName'],
      rating: (json['rating'] as num).toDouble(),
      review: json['review'],
      date: json['date'],
      verifiedPurchase: json['verifiedPurchase'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'userName': userName,
      'rating': rating,
      'review': review,
      'date': date,
      'verifiedPurchase': verifiedPurchase,
    };
  }
}