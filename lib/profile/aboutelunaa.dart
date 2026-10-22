import 'package:flutter/material.dart';

class AboutElunaaPage extends StatelessWidget {
  const AboutElunaaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Elunaa"),
        centerTitle: true,
          backgroundColor: Colors.grey.shade200,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/elunaa.jpeg"),
            ),

            const SizedBox(height: 15),

            const Text(
              "ELUNAA",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.purpleAccent,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Beauty • Fashion • Lifestyle",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 25),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "About Elunaa",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Elunaa is an online shopping platform designed to make beauty, fashion, skincare, and lifestyle shopping easy and enjoyable. Our goal is to provide customers with high-quality products, exciting offers, secure payments, and fast delivery at affordable prices.",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [

                    ListTile(
                      leading: Icon(Icons.favorite,
                          color: Colors.pink),
                      title: Text("Our Mission"),
                      subtitle: Text(
                          "To provide the best online shopping experience."),
                    ),

                    Divider(),

                    ListTile(
                      leading: Icon(Icons.verified,
                          color: Colors.green),
                      title: Text("100% Genuine Products"),
                    ),

                    Divider(),

                    ListTile(
                      leading: Icon(Icons.local_shipping,
                          color: Colors.blue),
                      title: Text("Fast Delivery"),
                    ),

                    Divider(),

                    ListTile(
                      leading: Icon(Icons.discount,
                          color: Colors.orange),
                      title: Text("Best Offers & Discounts"),
                    ),

                    Divider(),

                    ListTile(
                      leading: Icon(Icons.support_agent,
                          color: Colors.deepPurple),
                      title: Text("24/7 Customer Support"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [

                    ListTile(
                      leading: Icon(Icons.email,
                          color: Colors.red),
                      title: Text("support@elunaa.com"),
                    ),

                    Divider(),

                    ListTile(
                      leading: Icon(Icons.phone,
                          color: Colors.green),
                      title: Text("+91 98765 43210"),
                    ),

                    Divider(),

                    ListTile(
                      leading: Icon(Icons.language,
                          color: Colors.blue),
                      title: Text("www.elunaa.com"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Version 1.0.0",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "© 2026 Elunaa. All Rights Reserved.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}