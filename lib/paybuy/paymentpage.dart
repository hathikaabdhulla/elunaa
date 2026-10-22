import 'package:elunaa/model/cartmodel.dart';
import 'package:elunaa/paybuy/addresspage.dart';
import 'package:elunaa/paybuy/ordersucess.dart';
import 'package:elunaa/profile/orderpage.dart';
import 'package:elunaa/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  final List<CartModel> cartItems;

  // FIX: idhu Map<String, String> mattum than - AddressModel nu vera
  // oru field duplicate ah irundhichu, adhala compile error/wrong
  // data varum. AddressPage-la irundhu addresses[selectedIndex]
  // (Map<String, String>) than pass aaguthu, so idhu andha type ah
  // than match aagum.
  final Map<String, String> selectedAddress;

  const PaymentPage({
    super.key,
    required this.cartItems,
    required this.selectedAddress,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPayment = "Cash on Delivery";

  double get productTotal {
    return widget.cartItems.fold(
      0,
          (sum, item) => sum + (item.price * item.quantity),
    );
  }

  @override
  Widget build(BuildContext context) {
    double deliveryCharge = 50;
    double total = productTotal + deliveryCharge;

    // FIX: Map ah irundhu key vachu access pannanum (["name"] maadhiri),
    // .name/.phone/.address nu object maadhiri access panna mudiyathu.
    final address = widget.selectedAddress;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: const Text("Payment"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Delivery Address
            const Text(
              "Delivery Address",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),

            Card(
              child: ListTile(
                leading: const Icon(Icons.location_on),
                title: Text(address["name"] ?? ""),
                subtitle: Text(
                  "${address["phone"] ?? ""}\n"
                      "${address["address"] ?? ""}, ${address["city"] ?? ""}, "
                      "${address["state"] ?? ""} - ${address["pincode"] ?? ""}",
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Order Summary
            const Text(
              "Order Summary",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),

            Card(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.cartItems.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final item = widget.cartItems[index];

                  return ListTile(
                    leading: Image.asset(
                      item.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item.productName),
                    subtitle: Text("Qty: ${item.quantity}"),
                    trailing: Text(
                      "₹${item.price * item.quantity}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            /// Payment Method
            const Text(
              "Payment Method",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            RadioListTile<String>(
              value: "UPI",
              groupValue: selectedPayment,
              title: const Text("UPI"),
              onChanged: (value) {
                setState(() {
                  selectedPayment = value!;
                });
              },
            ),
            RadioListTile<String>(
              value: "Credit / Debit Card",
              groupValue: selectedPayment,
              title: const Text("Credit / Debit Card"),
              onChanged: (value) {
                setState(() {
                  selectedPayment = value!;
                });
              },
            ),
            RadioListTile<String>(
              value: "Net Banking",
              groupValue: selectedPayment,
              title: const Text("Net Banking"),
              onChanged: (value) {
                setState(() {
                  selectedPayment = value!;
                });
              },
            ),
            RadioListTile<String>(
              value: "Cash on Delivery",
              groupValue: selectedPayment,
              title: const Text("Cash on Delivery"),
              onChanged: (value) {
                setState(() {
                  selectedPayment = value!;
                });
              },
            ),

            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Product Price"),
                Text("₹$productTotal"),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Delivery Charge"),
                Text("₹50"),
              ],
            ),

            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "₹$total",
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent),
                onPressed: () {
                  for (var item in widget.cartItems) {
                    OrderStore.instance.addOrder(
                      OrderItem(
                        image: item.image,
                        name: item.productName,
                        price: "₹${item.price * item.quantity}",
                        status: "Order Placed",
                        date: DateTime.now(),
                      ),
                    );
                  }
                  Provider.of<CartProvider>(context, listen: false).clearCart();

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrderSuccessPage(),
                    ),
                  );
                },
                child: const Text(
                  "Place Order",
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