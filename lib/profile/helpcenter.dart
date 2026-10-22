import 'package:flutter/material.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Help Center"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            TextField(
              decoration: InputDecoration(
                hintText: "Search your issue...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Quick Help",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            _buildTile(
              context,
              Icons.chat,
              "Live Chat",
              "Chat with our support team",
            ),

            _buildTile(
              context,
              Icons.call,
              "Call Us",
              "+91 9876543210",
            ),

            _buildTile(
              context,
              Icons.email,
              "Email Support",
              "support@elunaa.com",
            ),

            _buildTile(
              context,
              Icons.message,
              "WhatsApp",
              "Chat on WhatsApp",
            ),

            const SizedBox(height: 20),

            const Text(
              "Frequently Asked Questions",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 10),

            ExpansionTile(
              title: const Text("How can I track my order?"),
              children: const [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Go to My Orders → Select your order → Tap Track Order.",
                  ),
                ),
              ],
            ),

            ExpansionTile(
              title: const Text("How do I cancel my order?"),
              children: const [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Open My Orders and tap Cancel Order if eligible.",
                  ),
                ),
              ],
            ),

            ExpansionTile(
              title: const Text("How do I return a product?"),
              children: const [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Go to Orders → Select Product → Return Product.",
                  ),
                ),
              ],
            ),

            ExpansionTile(
              title: const Text("Refund not received?"),
              children: const [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Refunds are processed within 5-7 business days.",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.report_problem,
                  color: Colors.red,
                ),
                title: const Text("Report an Issue"),
                subtitle: const Text("Tell us about your problem"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
            ),

            const SizedBox(height: 25),

            Center(
              child: Text(
                "Elunaa v1.0.0",
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(
      BuildContext context,
      IconData icon,
      String title,
      String subtitle,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.purple.shade100,
          child: Icon(
            icon,
            color: Colors.purpleAccent,
          ),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {},
      ),
    );
  }
}