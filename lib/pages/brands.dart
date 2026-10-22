import 'package:flutter/material.dart';
import 'old categories.dart';

class BrandsPage extends StatelessWidget {
  const BrandsPage({super.key});

  Widget _buildBrandGrid(BuildContext context, List<String> brands) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: brands.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Product model doesn't store a "brand" field yet,
            // so brand tap opens the full product list for now.
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CategoriesPage()),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            child: Text(
              brands[index],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 20, 12, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            children: const [
              Text(
                "View All",
                style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 4),
              Icon(Icons.arrow_forward, color: Colors.pink, size: 16),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topBrands = ["NYKAA Cosmetics", "LAKME", "L'OREAL PARIS", "MAYBELLINE", "MAC", "L'OREAL PROFESSIONNEL"];
    final luxeBrands = ["CHANEL", "ESTEE LAUDER", "KAMA AYURVEDA", "KERASTASE", "CLINIQUE", "LANEIGE"];
    final onlyAtNykaa = ["CHANEL", "SK-II", "ANUA", "PIXI", "e.l.f", "Kiehl's"];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Brands"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _sectionTitle("Top Brands"),
          _buildBrandGrid(context, topBrands),
          _sectionTitle("Luxe Brands"),
          _buildBrandGrid(context, luxeBrands),
          _sectionTitle("Only At Nykaa"),
          _buildBrandGrid(context, onlyAtNykaa),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}