import 'package:elunaa/profile/orderpage.dart';
import 'package:flutter/material.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  // NEW: Cancel/Return click pannumbodhu popup dialog kaatura function.
  // status "cancelled" na "Order Cancelled", "returned" na
  // "Return Accepted" nu message maarum.
  void showStatusPopup(String status) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                status == "cancelled" ? Icons.cancel : Icons.check_circle,
                color: status == "cancelled" ? Colors.red : Colors.green,
                size: 55,
              ),
              const SizedBox(height: 15),
              Text(
                status == "cancelled"
                    ? "Order Cancelled"
                    : "Return Accepted",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            SizedBox(
              width: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const OrdersPage()));
          },
        ),
        title: const Text(
          "Tracking Details",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

//==========================
// DELIVERY PARTNER CARD
//==========================

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                children: [

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [

                        Text(
                          "Delivery Partner",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),

                        SizedBox(height: 6),

                        Text(
                          "Delhivery",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: 1,
                    height: 55,
                    color: Colors.grey.shade300,
                  ),

                  const SizedBox(width: 18),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Text(
                          "Tracking ID",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Row(
                          children: [

                            const Expanded(
                              child: Text(
                                "133901305733902",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),

                            IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Tracking ID Copied"),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.copy),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

//==========================
// INFO BOX
//==========================

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purpleAccent.shade100,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.purpleAccent.shade100,
                ),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Icon(
                    Icons.info,
                    color: Colors.purpleAccent,
                  ),

                  SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      "This is the same information our customer service agents see.",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

//==========================
// TIMELINE START
//==========================

            buildStep(
              title: "Order Confirmed",
              subtitle:
              "Your order has been placed. It will be shipped soon!",
              date: "18 Jun 2026 - 02:25 PM",
              isLast: false,
            ),

            buildStep(
              title: "Order Shipped",
              subtitle: "Your order is on the way",
              date: "19 Jun 2026 - 12:13 PM",
              isLast: false,
              completed: true,
            ),

            buildStep(
              title: "Reached Chennai_Sriperumbudur_GW (Tamil Nadu)",
              subtitle:
              "Your order has reached the hub in Chennai_Sriperumbudur_GW (Tamil Nadu)",
              date: "19 Jun 2026 - 03:49 PM",
              isLast: false,
            ),

            buildStep(
              title: "Reached Chennai_Sriperumbudur_GW (Tamil Nadu)",
              subtitle:
              "Your order has reached the hub in Chennai_Sriperumbudur_GW (Tamil Nadu)",
              date: "19 Jun 2026 - 06:08 PM",
              isLast: false,
            ),

            buildStep(
              title: "Reached Chennai_Sriperumbudur_GW (Tamil Nadu)",
              subtitle:
              "Your order has reached the hub in Chennai_Sriperumbudur_GW (Tamil Nadu)",
              date: "20 Jun 2026 - 02:22 AM",
              isLast: false,
            ),

            buildStep(
              title: "Out for Delivery",
              subtitle:
              "Our courier partner is on the way to deliver your order!",
              date: "20 Jun 2026 - 09:31 AM",
              isLast: false,
            ),

            buildStep(
              title: "Delivered On Sat, 20 Jun",
              subtitle: "Order was handed to the resident",
              date: "20 Jun 2026 - 11:45 AM",
              isLast: true,

            ),

            const SizedBox(height: 10),

//==========================
// SEE ALL UPDATES
//==========================

            GestureDetector(
              onTap: () {
                // TODO: navigate to full updates page if you have one
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  children: [
                    Text(
                      "See All Updates",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.chevron_right, color: Colors.blue),
                  ],
                ),
              ),
            ),

            const Divider(),

            const SizedBox(height: 12),

//==========================
// CANCEL / RETURN BUTTONS
//==========================

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    onPressed: () {
                      showStatusPopup("cancelled");
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    onPressed: () {
                      showStatusPopup("returned");
                    },
                    child: const Text(
                      "Return",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget buildStep({
    required String title,
    required String subtitle,
    required String date,
    required bool isLast,
    bool completed = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: completed
                    ? const Icon(Icons.check, color: Colors.white, size: 15)
                    : null,
              ),
              if (!isLast)
                Container(
                  width: 3,
                  height: 90,
                  color: Colors.green,
                ),
            ],
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    date,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}