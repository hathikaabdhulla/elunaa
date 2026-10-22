import 'package:elunaa/profile/trackorder.dart';
import 'package:elunaa/screen/offerpage.dart';
import 'package:flutter/material.dart';


class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  final List<Map<String, dynamic>> notifications = [
    {
      "title": "Order Confirmed",
      "subtitle": "Your order #12345 has been confirmed.",
      "icon": Icons.check_circle,
      "color": Colors.green,
      "time": "2 mins ago",
    },
    {
      "title": "Order Shipped",
      "subtitle": "Your order is on the way.",
      "icon": Icons.local_shipping,
      "color": Colors.blue,
      "time": "30 mins ago",
    },
    {
      "title": "Special Offer",
      "subtitle": "Get 50% OFF on Electronics.",
      "icon": Icons.local_offer,
      "color": Colors.orange,
      "time": "1 hour ago",
    },
    {
      "title": "Wishlist Reminder",
      "subtitle": "An item in your wishlist is on sale.",
      "icon": Icons.favorite,
      "color": Colors.red,
      "time": "3 hours ago",
    },
    {
      "title": "Flash Sale",
      "subtitle": "Flash Sale starts at 6:00 PM.",
      "icon": Icons.flash_on,
      "color": Colors.deepOrange,
      "time": "Today",
    },
    {
      "title": "Payment Successful",
      "subtitle": "Your payment has been received.",
      "icon": Icons.payment,
      "color": Colors.teal,
      "time": "Yesterday",
    },
    {
      "title": "New Arrivals",
      "subtitle": "Check out the latest fashion collection.",
      "icon": Icons.new_releases,
      "color": Colors.purple,
      "time": "Yesterday",
    },
    {
      "title": "Coupon Available",
      "subtitle": "Use ELUNAA20 to save ₹200.",
      "icon": Icons.card_giftcard,
      "color": Colors.amber,
      "time": "2 days ago",
    },
  ];

  void _handleNotificationTap(BuildContext context, String title) {
    if (title == "Special Offer") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>  OfferPage(),
        ),
      );
    } else if (title == "Order Shipped") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const TrackingPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            elevation: 3,
            child: ListTile(
              onTap: () {
                _handleNotificationTap(
                  context,
                  item["title"],
                );
              },
              leading: CircleAvatar(
                backgroundColor: item["color"],
                child: Icon(
                  item["icon"],
                  color: Colors.white,
                ),
              ),
              title: Text(
                item["title"],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(item["subtitle"]),
              trailing: Text(
                item["time"],
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}