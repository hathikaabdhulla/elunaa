import 'package:flutter/material.dart';
import 'categories page.dart';
import 'brands.dart';
import 'old categories.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> shopSections = [
      {
        "title": "Categories",
        "colors": [Colors.red.shade400, Colors.orange.shade200, Colors.blue.shade300],
        "icons": [Icons.brush, Icons.face_retouching_natural, Icons.local_florist],
        "onTap": (BuildContext ctx) {
          Navigator.push(ctx, MaterialPageRoute(builder: (_) => const CategoryListPage()));
        },
      },
      {
        "title": "Brands",
        "colors": [Colors.black87, Colors.grey.shade700, Colors.grey.shade900],
        "icons": [Icons.storefront, Icons.storefront, Icons.storefront],
        "onTap": (BuildContext ctx) {
          Navigator.push(ctx, MaterialPageRoute(builder: (_) => const BrandsPage()));
        },
      },
      {
        "title": "Luxe",
        "colors": [Colors.black, Colors.grey.shade800, Colors.grey.shade600],
        "icons": [Icons.diamond, Icons.diamond, Icons.diamond],
        "onTap": (BuildContext ctx) {
          Navigator.push(ctx, MaterialPageRoute(builder: (_) => const CategoriesPage()));
        },
      },
      {
        "title": "Bestsellers",
        "colors": [Colors.pink.shade200, Colors.brown.shade300, Colors.blue.shade400],
        "icons": [Icons.brush, Icons.opacity, Icons.local_drink],
        "onTap": (BuildContext ctx) {
          Navigator.push(ctx, MaterialPageRoute(builder: (_) => const CategoriesPage()));
        },
      },
      {
        "title": "New Launches",
        "colors": [Colors.brown.shade400, Colors.pink.shade100, Colors.amber.shade200],
        "icons": [Icons.face, Icons.spa, Icons.opacity],
        "onTap": (BuildContext ctx) {
          Navigator.push(ctx, MaterialPageRoute(builder: (_) => const CategoriesPage()));
        },
      },
      {
        "title": "The Gift Store",
        "colors": [Colors.pink.shade100, Colors.red.shade400, Colors.amber.shade400],
        "icons": [Icons.grid_view, Icons.brush, Icons.card_giftcard],
        "onTap": (BuildContext ctx) {
          Navigator.push(ctx, MaterialPageRoute(builder: (_) => const CategoriesPage()));
        },
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Shop"),
        centerTitle: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: shopSections.length,
        itemBuilder: (context, index) {
          final section = shopSections[index];
          final colors = section["colors"] as List<Color>;
          final icons = section["icons"] as List<IconData>;

          return GestureDetector(
            onTap: () => section["onTap"](context),
            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    section["title"],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 60,
                    child: Stack(
                      children: List.generate(3, (i) {
                        return Positioned(
                          left: i * 32.0,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 27,
                              backgroundColor: colors[i],
                              child: Icon(icons[i], color: Colors.white, size: 24),
                            ),
                          ),
                        );
                      }),
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