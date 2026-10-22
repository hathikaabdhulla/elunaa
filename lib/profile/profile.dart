import 'package:elunaa/login/login.dart';
import 'package:elunaa/paybuy/addresspage.dart';
import 'package:elunaa/paybuy/paymentpage.dart';
import 'package:elunaa/profile/aboutelunaa.dart';
import 'package:elunaa/profile/editprofile.dart';
import 'package:elunaa/profile/orderpage.dart';
import 'package:elunaa/profile/privacypolicy.dart';
import 'package:elunaa/profile/termsconditions.dart';
import 'package:elunaa/screen/offerpage.dart' hide OrdersPage;
import 'package:elunaa/screen/wish_list.dart';
import 'package:flutter/material.dart';
import 'package:elunaa/profile/darkmode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:elunaa/profile/helpcenter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String username = "Guest User";
  String email = "guest@elunaa.com";

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.getString("username") ?? "Guest User";
      email = prefs.getString("email") ?? "guest@elunaa.com";
    });
  }

  Widget menuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 22,
          backgroundColor: Colors.purpleAccent[100],
          child: Icon(
            icon,
            color: Colors.deepPurple,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 19,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios_rounded,
          color: Theme.of(context).iconTheme.color
        ),
        onTap: onTap,
      ),
    );
  }

  Future<void> logout() async {

    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    await prefs.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginPage(),
      ),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: SafeArea(

        child: SingleChildScrollView(

          child: Column(

            children: [

              Container(

                width: double.infinity,

                padding: const EdgeInsets.only(
                  top: 30,
                  bottom: 30,
                ),

                decoration: const BoxDecoration(

                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFBA68C8),
                      Color(0xFFAB47BC),
                    ],
                  ),

                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                ),

                child: Column(

                  children: [

                    const CircleAvatar(
                      radius: 45,
                      backgroundImage:
                      AssetImage("assets/images/img.png"),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      username,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      email,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),

                  ],
                ),
              ),

              const SizedBox(height: 20),

              menuTile(
                icon: Icons.shopping_bag_outlined,
                title: "My Orders",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const OrdersPage(),
                    ),
                  );
                },
              ),
              menuTile(
                icon: Icons.brightness_3,
                title: "Dark Mode",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DarkModePage(),
                    ),
                  );
                },
              ),

              menuTile(
                icon: Icons.favorite_border,
                title: "Wishlist",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const WishlistPage(),
                    ),
                  );
                },
              ),

              menuTile(
                icon: Icons.local_offer_outlined,
                title: "My Coupons",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OfferPage(),
                    ),
                  );
                },
              ),

              menuTile(
                icon: Icons.location_on_outlined,
                title: "My Address",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AddressPage(cartItems: [],),
                    ),
                  );
                },
              ),

              menuTile(
                icon: Icons.location_on_outlined,
                title: "Profile",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EditProfilePage(),
                    ),
                  );
                },
              ),

              menuTile(
                icon: Icons.support_agent,
                title: "Help Center",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HelpCenterPage(),
                    ),
                  );
                },
              ),

              menuTile(
                icon: Icons.info_outline,
                title: "About Elunaa",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AboutElunaaPage(),
                    ),
                  );
                },
              ),

              menuTile(
                icon: Icons.lock_outline,
                title: "Privacy Policy",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PrivacyPolicyPage(),
                    ),
                  );
                },
              ),

              menuTile(
                icon: Icons.description_outlined,
                title: "Terms & Conditions",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TermsConditionsPage(),
                    ),
                  );
                },
              ),

              menuTile(
                icon: Icons.logout,
                title: "Logout",
                onTap: () {

                  showDialog(
                    context: context,
                    builder: (context) {

                      return AlertDialog(

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),

                        title: const Text("Logout"),

                        content: const Text(
                            "Are you sure you want to logout?"
                        ),

                        actions: [

                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purpleAccent,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              logout();
                            },
                            child: const Text("Logout",),
                          ),

                        ],
                      );
                    },
                  );

                },
              ),

              const SizedBox(height: 20),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.purpleAccent[900],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: const [

                    Icon(
                      Icons.favorite,
                      color: Colors.purpleAccent,
                      size: 35,
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Thank you for shopping with Elunaa ❤️",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(
                      "Beauty • Fashion • Lifestyle",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Version 1.0.0",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 30),

            ],
          ),
        ),
      ),
    );
  }
}