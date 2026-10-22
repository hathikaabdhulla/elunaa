import 'package:elunaa/paybuy/addresspage.dart';
import 'package:flutter/material.dart';

class DeliveryPage extends StatelessWidget {
  const DeliveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("Delivery Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Delivery Address
            Card(
              elevation: 3,
              child: ListTile(
                leading: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
                title: const Text(
                  "Delivery Address",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  "Hathika A\n123, Anna Nagar,\nMadurai - 625020\nTamil Nadu",
                ),
                trailing: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AddressPage(cartItems: [],),
                      ),
                    );

                  },
                  child: const Text("Change"),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Delivery Information",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: Column(
                children: const [

                  ListTile(
                    leading: Icon(Icons.local_shipping),
                    title: Text("Standard Delivery"),
                    subtitle: Text("Delivery in 3 - 5 Days"),
                  ),

                  Divider(),

                  ListTile(
                    leading: Icon(Icons.flash_on),
                    title: Text("Express Delivery"),
                    subtitle: Text("Delivery Tomorrow"),
                  ),

                  Divider(),

                  ListTile(
                    leading: Icon(Icons.money),
                    title: Text("Cash on Delivery"),
                    subtitle: Text("Available"),
                  ),

                  Divider(),

                  ListTile(
                    leading: Icon(Icons.assignment_return),
                    title: Text("Return Policy"),
                    subtitle: Text("7 Days Easy Return"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Shipping Charges",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: Column(
                children: const [

                  ListTile(
                    title: Text("Product Price"),
                    trailing: Text("₹999"),
                  ),

                  Divider(),

                  ListTile(
                    title: Text("Delivery Charge"),
                    trailing: Text(
                      "FREE",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),

                  Divider(),

                  ListTile(
                    title: Text(
                      "Total",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      "₹999",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {

                    Navigator.pop(
                      context);

                },
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}