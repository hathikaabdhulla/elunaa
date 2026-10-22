import 'package:elunaa/model/cartmodel.dart';
import 'package:elunaa/model/product_model.dart';
import 'package:elunaa/paybuy/addresspage.dart';
import 'package:elunaa/profile/orderpage.dart';
import 'package:flutter/material.dart';
import 'ordersucess.dart';

class CheckoutPage extends StatefulWidget {
  final Product product;
  const CheckoutPage({super.key, required this.product});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int quantity = 1;
  final double deliveryCharge = 50;

  @override
  Widget build(BuildContext context) {
    double subtotal = widget.product.price * quantity;
    double total = subtotal + deliveryCharge;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: const Text("Checkout"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ---------- Product Card ----------
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Image.asset(
                      widget.product.image,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(widget.product.description),
                          const SizedBox(height: 8),
                          Text(
                            "₹${widget.product.price}",
                            style: const TextStyle(
                              color: Colors.purpleAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ---------- Quantity ----------
            const Text(
              "Quantity",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (quantity > 1) {
                      setState(() => quantity--);
                    }
                  },
                  icon: const Icon(Icons.remove_circle),
                ),
                Text(quantity.toString(), style: const TextStyle(fontSize: 18)),
                IconButton(
                  onPressed: () => setState(() => quantity++),
                  icon: const Icon(Icons.add_circle),
                ),
              ],
            ),

            const Divider(height: 30),

            // ---------- Price Breakdown ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Subtotal"),
                Text("₹${subtotal.toStringAsFixed(2)}"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Delivery Charge"),
                Text("₹${deliveryCharge.toStringAsFixed(2)}"),
              ],
            ),
            const Divider(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Amount",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  "₹${total.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),

            const Spacer(),

            // ---------- Place Order Button ----------
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  // ----- IDHU THAAN MUKKIYAM -----
                  // "Place Order" click pannina, andha product-ah
                  // OrderStore la add pannuvom (quantity, total amount sericha).
                  // Idhu than Orders page ku andha product-ah kondu poi kaatuvadhu.
                  OrderStore.instance.addOrder(
                    OrderItem(
                      image: widget.product.image,
                      name: widget.product.name,
                      price: total.toStringAsFixed(2),
                      status: "Processing",
                      date: DateTime.now(),
                    ),
                  );

                  // FIX: munnaadi ingu cartItems: [] nu empty list pass pannirundhom,
                  // adhaala AddressPage/order summary ku andha product data poagala.
                  // Ippo "Buy Now" product-ah CartModel ah convert panni, andha
                  // list-ah AddressPage ku pass pannurom - summary/payment page la
                  // product correct ah show aagum.
                  final buyNowItem = CartModel(
                    productName: widget.product.name,
                    image: widget.product.image,
                    price: widget.product.price,
                    quantity: quantity,
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddressPage(
                        cartItems: [buyNowItem],
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}