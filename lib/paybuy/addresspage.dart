import 'package:elunaa/data/product_data.dart';
import 'package:elunaa/model/cartmodel.dart';
import 'package:elunaa/paybuy/paymentpage.dart';
import 'package:flutter/material.dart';
import 'package:elunaa/profile/editaddress.dart';

class AddressPage extends StatefulWidget {
  final List<CartModel> cartItems;

  const AddressPage({super.key, required this.cartItems});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  int selectedIndex = 0;

  List<Map<String, String>> addresses = [
    {
      "name": "Hathika",
      "phone": "9876543210",
      "address": "12, Anna Nagar",
      "city": "Madurai",
      "state": "Tamil Nadu",
      "pincode": "625020",
      "type": "Home",
    },
    {
      "name": "Hathika",
      "phone": "9876543210",
      "address": "45, KK Nagar",
      "city": "Madurai",
      "state": "Tamil Nadu",
      "pincode": "625001",
      "type": "Office",
    },
  ];

  Future<void> addAddress() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const EditAddressPage(
          name: "",
          phone: "",
          address: "",
          city: "",
          state: "",
          pincode: "",
        ),
      ),
    );

    if (result != null) {
      setState(() {
        addresses.add({
          "name": result["name"],
          "phone": result["phone"],
          "address": result["address"],
          "city": result["city"],
          "state": result["state"],
          "pincode": result["pincode"],
          "type": "Home",
        });
      });
    }
  }

  Future<void> editAddress(int index) async {
    final item = addresses[index];

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditAddressPage(
          name: item["name"]!,
          phone: item["phone"]!,
          address: item["address"]!,
          city: item["city"]!,
          state: item["state"]!,
          pincode: item["pincode"]!,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        addresses[index] = {
          "name": result["name"],
          "phone": result["phone"],
          "address": result["address"],
          "city": result["city"],
          "state": result["state"],
          "pincode": result["pincode"],
          "type": item["type"]!,
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,

      appBar: AppBar(
        title: const Text("My Addresses"),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: addAddress,
        icon: const Icon(Icons.add),
        label: const Text("Add Address"),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          final item = addresses[index];

          return Card(
            elevation: 5,
            margin: const EdgeInsets.only(bottom: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: RadioListTile(
              value: index,
              groupValue: selectedIndex,
              onChanged: (value) {
                setState(() {
                  selectedIndex = value!;
                });
              },
              title: Row(
                children: [
                  Text(
                    item["name"]!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.purpleAccent.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      item["type"]!,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  Text(item["phone"]!),

                  const SizedBox(height: 5),

                  Text(
                    "${item["address"]}, ${item["city"]}, ${item["state"]} - ${item["pincode"]}",
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          editAddress(index);
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text("Edit"),
                      ),

                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            addresses.removeAt(index);

                            if (selectedIndex >= addresses.length) {
                              selectedIndex = 0;
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.purpleAccent,
                        ),
                        label: const Text(
                          "Delete",
                          style: TextStyle(
                            color: Colors.purpleAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(15),
        color: Colors.white,
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PaymentPage(
                    cartItems: widget.cartItems,
                    selectedAddress: addresses[selectedIndex],
                  ),
                ),
              );
            },
            child: const Text(
              "Continue",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}