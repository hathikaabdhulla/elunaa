import 'package:flutter/material.dart';
import 'old categories.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categoryBanners = [
      {
        "title": "Skincare",
        "category": "Skincare",
        "colors": [Colors.pink.shade100, Colors.orange.shade100],
        "icon": Icons.spa,
      },
      {
        "title": "Makeup",
        "category": "Makeup",
        "colors": [Colors.pink.shade200, Colors.pink.shade50],
        "icon": Icons.brush,
      },
      {
        "title": "Hair Care",
        "category": "Haircare",
        "colors": [Colors.brown.shade200, Colors.brown.shade50],
        "icon": Icons.face_retouching_natural,
      },
      {
        "title": "Personal Care",
        "category": "BodyWash",
        "colors": [Colors.purple.shade200, Colors.pink.shade100],
        "icon": Icons.local_florist_sharp,
      },
      {
        "title": "Fragrance",
        "category": "Fragrance",
        "colors": [Colors.pink.shade300, Colors.pink.shade50],
        "icon": Icons.local_florist,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Categories"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: categoryBanners.length,
        itemBuilder: (context, index) {
          final item = categoryBanners[index];
          final colors = item["colors"] as List<Color>;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoriesPage(
                    initialCategory: item["category"],
                  ),
                ),
              );
            },
            child: Container(
              height: 150,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: colors,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      item["title"],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white.withOpacity(0.4),
                      child: Icon(item["icon"], size: 45, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}