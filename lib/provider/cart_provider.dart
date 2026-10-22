import 'package:flutter/material.dart';
import '../model/cartmodel.dart';
import '../model/product_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartModel> _cartItems = [];

  List<CartModel> get cartItems => _cartItems;

  // Product cart la already irukka nu check panna (Add to Cart <-> Go to Cart button ku)
  bool isInCart(Product product) {
    return _cartItems.any((item) => item.productName == product.name);
  }

  void addToCart(Product product) {
    int index = _cartItems.indexWhere(
          (item) => item.productName == product.name,
    );

    if (index != -1) {
      _cartItems[index].quantity++;
    } else {
      _cartItems.add(
        CartModel(
          productName: product.name,
          image: product.image,
          price: product.price,
          quantity: 1,
        ),
      );
    }

    notifyListeners();
  }

  void removeFromCart(CartModel item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  // Order place aana pinnadi ithai call pannunga -> cart empty aagidum
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  double get totalPrice {
    double total = 0;
    for (var item in _cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }
}