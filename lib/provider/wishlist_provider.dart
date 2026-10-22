import 'package:elunaa/model/product_model.dart';
import 'package:flutter/material.dart';


class WishlistProvider extends ChangeNotifier {
  final List<Product> _wishlistItems = [];

  // Get Wishlist Items
  List<Product> get wishlistItems => _wishlistItems;

  // Total Wishlist Items
  int get itemCount => _wishlistItems.length;

  // Add Product to Wishlist
  void addToWishlist(Product product) {
    if (!_wishlistItems.contains(product)) {
      _wishlistItems.add(product);
      notifyListeners();
    }
  }

  // Remove Product from Wishlist
  void removeFromWishlist(Product product) {
    _wishlistItems.remove(product);
    notifyListeners();
  }

  // Toggle Wishlist
  void toggleWishlist(Product product) {
    if (_wishlistItems.contains(product)) {
      _wishlistItems.remove(product);
    } else {
      _wishlistItems.add(product);
    }
    notifyListeners();
  }

  // Check if Product is in Wishlist
  bool isInWishlist(Product product) {
    return _wishlistItems.contains(product);
  }

  // Clear Wishlist
  void clearWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }
}