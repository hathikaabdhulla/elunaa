import 'package:flutter/material.dart';
import 'package:elunaa/screen/write page.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> reviews = [
      {
        "name": "Rahul",
        "rating": 5,
        "date": "12 Jul 2026",
        "review": "Excellent product. Worth the price!"
      },
      {
        "name": "Priya",
        "rating": 4,
        "date": "10 Jul 2026",
        "review": "Good quality and fast delivery."
      },
      {
        "name": "Arun",
        "rating": 5,
        "date": "08 Jul 2026",
        "review": "Very satisfied. Highly recommended."
      },
      {
        "name": "Kavya",
        "rating": 3,
        "date": "05 Jul 2026",
        "review": "Average product."
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("Ratings & Reviews"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const WriteReviewPage(),
            ),
          );
        },
        icon: const Icon(Icons.edit),
        label: const Text("Write Review"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 20),

            const Text(
              "4.5",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                    (index) => const Icon(
                  Icons.star,
                  color: Colors.purpleAccent,
                ),
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "190 Ratings & 120 Reviews",
              style: TextStyle(color: Colors.grey),
            ),

            const Divider(height: 30),

            buildRatingBar("5", 120),
            buildRatingBar("4", 45),
            buildRatingBar("3", 18),
            buildRatingBar("2", 5),
            buildRatingBar("1", 2),

            const Divider(height: 30),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [

                            const CircleAvatar(
                              child: Icon(Icons.person),
                            ),

                            const SizedBox(width: 10),

                            Text(
                              review["name"],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        Row(
                          children: List.generate(
                            review["rating"],
                                (index) => const Icon(
                              Icons.star,
                              size: 18,
                              color: Colors.purpleAccent,
                            ),
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          review["date"],
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          review["review"],
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget buildRatingBar(String star, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 4,
      ),
      child: Row(
        children: [
          Text("$star ⭐"),

          const SizedBox(width: 10),

          Expanded(
            child: LinearProgressIndicator(
              value: count / 120,
              minHeight: 8,
            ),
          ),

          const SizedBox(width: 10),

          Text(count.toString()),
        ],
      ),
    );
  }
}