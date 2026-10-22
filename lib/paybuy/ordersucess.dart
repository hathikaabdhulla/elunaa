import 'package:elunaa/profile/orderpage.dart';
import 'package:flutter/material.dart';
// ---------------- ORDER SUCCESSFUL PAGE ----------------
class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 90),
            const SizedBox(height: 20),
            const Text(
              "Order Successful!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Your Order Placed Successfully",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent),
              onPressed: () {
                // Idha click pannina "My Orders" page ku poidum,
                // andha product ippo appuram irukum (already OrderStore la add aagiduchu)
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const OrdersPage()),
                      (route) => false, // back stack clear pannitu fresh-a Orders page open aagum
                );
              },
              child: const Text("View My Orders", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}