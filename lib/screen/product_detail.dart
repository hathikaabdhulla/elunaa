import 'package:elunaa/model/product_model.dart';
import 'package:elunaa/paybuy/buynow.dart';
import 'package:elunaa/profile/orderpage.dart';
import 'package:elunaa/provider/cart_provider.dart';
import 'package:elunaa/screen/cart_page.dart';
import 'package:elunaa/screen/offerpage.dart';
import 'package:elunaa/screen/review.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/product_data.dart';
import 'package:elunaa/screen/Delivarypage.dart';
// CheckoutPage import path - unga project structure ku match panni change pannikonga

class ProductDetailPage extends StatelessWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final similar = productList.where((p) => p.id != product.id).take(4).toList();

    // Provider ah watch panrom, cart la item add/remove aana button automatic ah update aagum
    final cartProvider = Provider.of<CartProvider>(context);
    final bool isInCart = cartProvider.isInCart(product);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: Text(product.name, style: const TextStyle(color: Colors.black)),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                if (isInCart) {
                  // Already cart la irukku -> cart page ku poidu
                   {Navigator.push(context, MaterialPageRoute(
                     builder: (_) => const CartPage(),
                   ),
                   );
                   }
                } else {
                  // Illana cart la add pannitu, cart page ku poidum
                  context.read<CartProvider>().addToCart(product);
                  {Navigator.push(context, MaterialPageRoute(
                    builder: (_) => const CartPage(),
                  ),
                  );
                  }
                }
              },
              child: Text(isInCart ? "Go to Cart" : "Add to Cart"),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purpleAccent,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                // "Buy Now" click pannina -> Checkout page ku poidum
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutPage(product: product),
                  ),
                );
              },
              child: const Text("Buy Now", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          )
        ]),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(product.image, height: 250, fit: BoxFit.cover),
          ),
          const SizedBox(height: 16),
          Text(product.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text("₹${product.price}",
              style: const TextStyle(fontSize: 20, color: Colors.purpleAccent, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(product.description),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.star, color: Colors.amber),
            title: const Text("4.5 ★ (245 Ratings)"),
            subtitle: const Text("Tap to view reviews"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ReviewPage()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.local_offer, color: Colors.red),
            title: const Text("Offers"),
            subtitle: const Text("10% Instant Discount\nFree Shipping"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const OrdersPage()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.local_shipping),
            title: const Text("Delivery Details"),
            subtitle: const Text("Delivery in 2-4 days"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DeliveryPage()),
            ),
          ),
          const SizedBox(height: 12),
          const Text("Similar Products", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: similar.length,
              itemBuilder: (c, i) {
                final p = similar[i];
                return GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => ProductDetailPage(product: p)),
                  ),
                  child: Container(
                    width: 150,
                    margin: const EdgeInsets.only(right: 12),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(children: [
                          Expanded(child: Image.asset(p.image)),
                          Text(p.name, maxLines: 1),
                          Text("₹${p.price}", style: const TextStyle(color: Colors.green))
                        ]),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}