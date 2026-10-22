import 'package:flutter/material.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Terms & Conditions"),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [

                Center(
                  child: Icon(
                    Icons.description,
                    color: Colors.purpleAccent,
                    size: 70,
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  "Terms & Conditions",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  "Welcome to Elunaa. By using our application, you agree to the following terms and conditions.",
                  style: TextStyle(fontSize: 16),
                ),

                SizedBox(height: 20),

                Text(
                  "1. Account",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "You are responsible for maintaining the confidentiality of your account and password.",
                ),

                SizedBox(height: 20),

                Text(
                  "2. Orders",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "All orders are subject to product availability and confirmation of payment.",
                ),

                SizedBox(height: 20),

                Text(
                  "3. Payments",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Payments must be completed using the available payment methods within the application.",
                ),

                SizedBox(height: 20),

                Text(
                  "4. Shipping",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Delivery dates are estimates and may vary depending on your location and courier service.",
                ),

                SizedBox(height: 20),

                Text(
                  "5. Returns & Refunds",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Products can be returned according to our return policy. Refunds will be processed after verification.",
                ),

                SizedBox(height: 20),

                Text(
                  "6. Privacy",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Your personal information is handled securely and is never shared without your consent.",
                ),

                SizedBox(height: 20),

                Text(
                  "7. Updates",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Elunaa reserves the right to modify these terms at any time. Continued use of the app indicates your acceptance of the updated terms.",
                ),

                SizedBox(height: 25),

                Center(
                  child: Text(
                    "Thank you for choosing Elunaa ❤️",
                    style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}