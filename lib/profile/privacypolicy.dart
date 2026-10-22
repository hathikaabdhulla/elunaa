import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Privacy Policy"),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(
                      Icons.privacy_tip,
                      color: Colors.purpleAccent,
                      size: 60,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Your Privacy Matters",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Elunaa respects your privacy and is committed to protecting your personal information.",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            buildSection(
              Icons.person,
              "Information We Collect",
              "We collect your name, email address, phone number, shipping address and payment details when you create an account or place an order.",
            ),

            buildSection(
              Icons.shopping_bag,
              "How We Use Your Information",
              "Your information is used to process orders, improve our services, personalize your shopping experience and provide customer support.",
            ),

            buildSection(
              Icons.lock,
              "Data Security",
              "We use secure technologies to protect your personal information from unauthorized access or misuse.",
            ),

            buildSection(
              Icons.share,
              "Information Sharing",
              "We never sell your personal information. Data is shared only with trusted delivery and payment partners when required.",
            ),

            buildSection(
              Icons.cookie,
              "Cookies",
              "Cookies help us remember your preferences and improve the app experience.",
            ),

            buildSection(
              Icons.update,
              "Policy Updates",
              "This Privacy Policy may be updated occasionally. Changes will be reflected within the application.",
            ),

            const SizedBox(height: 25),

            Card(
              color: Colors.purple.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: Colors.purple,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "For any privacy related questions, contact us at support@elunaa.com",
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildSection(
      IconData icon,
      String title,
      String content,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            CircleAvatar(
              backgroundColor: Colors.purple.shade100,
              child: Icon(
                icon,
                color: Colors.purple,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    content,
                    style: const TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}