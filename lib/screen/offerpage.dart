import 'package:elunaa/data/product_data.dart';
import 'package:elunaa/screen/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OfferPage extends StatelessWidget {
  OfferPage({super.key});

  final List<Map<String, dynamic>> offers = [
    {
      "title": "LAKME Flat 50% OFF",
      "description": "Get 50% discount on orders above ₹999.",
      "code": "SAVE50",
      "product": productList[0],
    },
    {
      "title": "DOT AND KEY 20% OFF for New Users",
      "description": "Applicable on your first purchase.",
      "code": "WELCOME20",
      "product": productList[1],
    },
    {
      "title": "FRAGURACE Free Delivery",
      "description": "Free delivery on orders above ₹499.",
      "code": "FREEDEL",
      "product": productList[5],
    },
    {
      "title": "WISHCARE Buy 1 Get 1",
      "description": "Applicable on selected products.",
      "code": "B1G1QR",
      "product": productList[2],
    },
    {
      "title": "BEAUTY OF JOSEON 80% OFFER",
      "description": "Applicable on selected products.",
      "code": "B1G1F1G",
      "product": productList[0],
    },
    {
      "title": "QUEENCH Buy 2 Get 1",
      "description": "Applicable on selected products.",
      "code": "B1G6Y7H8",
      "product": productList[6],
    },
    {
      "title": "BBLUNT Buy 1 Get 2",
      "description": "Applicable on selected products.",
      "code": "B1EDT2",
      "product": productList[4],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("Offers"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: offers.length,
        itemBuilder: (context, index) {
          final offer = offers[index];


           return InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailPage(
                      product: offer["product"],
                    ),
                  ),
                );
              },
               child: Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "OFFER",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          offer["title"]!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    offer["description"]!,
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.purpleAccent),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            offer["code"]!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.purpleAccent,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(text: offer["code"]!),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "${offer["code"]} copied!",
                              ),
                            ),
                          );
                        },
                        child: const Text("Copy"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
               ),
          );
        },
      ),
    );
  }
}