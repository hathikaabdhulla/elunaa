class CartModel {
  final String productName;
  final String image;
  final double price;
  int quantity;


  CartModel({
    required this.productName,
    required this.image,
    required this.price,
    this.quantity = 1,
  });


}