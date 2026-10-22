import 'package:elunaa/model/product_model.dart';
import 'package:elunaa/screen/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/product_data.dart';
import 'package:elunaa/model/product_model.dart';
import 'package:elunaa/model/product_model.dart';
import 'package:elunaa/provider/cart_provider.dart';
import '../provider/wishlist_provider.dart';


class CategoriesPage extends StatefulWidget {
  // NEW: lets other pages (Category List / Brands / Shop) open this
  // page pre-filtered to a category. Defaults to "All" so old calls
  // like `CategoriesPage()` still work exactly as before.
  final String initialCategory;

  const CategoriesPage({super.key, this.initialCategory = "All"});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> categories = [
    {
      "name": "All",
      "icon": Icons.grid_view,
    },
    {
      "name": "Makeup",
      "icon": Icons.brush,
    },
    {
      "name": "Skincare",
      "icon": Icons.spa,
    },
    {
      "name": "Haircare",
      "icon": Icons.face_retouching_natural,
    },
    {
      "name": "BodyWash",
      "icon": Icons.local_florist_sharp,
    },
    {
      "name": "Fragrance",
      "icon": Icons.local_florist,
    },
  ];

  // NEW: initialized from widget.initialCategory instead of a fixed "All"
  late String selectedCategory;
  String searchText = "";

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
  }

  List<Product> get filteredProducts {
    return productList.where((product) {
      final matchCategory = selectedCategory == "All"
          ? true
          : product.category.toLowerCase() ==
          selectedCategory.toLowerCase();

      final matchSearch = product.name
          .toLowerCase()
          .contains(searchText.toLowerCase()) ||
          product.description
              .toLowerCase()
              .contains(searchText.toLowerCase());

      return matchCategory && matchSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Categories"),
        centerTitle: true,
      ),

      body: Column(
        children: [
          const SizedBox(height: 10),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search Products",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),

          const SizedBox(height: 15),

          // Category Chips
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];

                final isSelected =
                    selectedCategory == category["name"];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = category["name"];
                    });
                  },
                  child: Container(
                    width: 90,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.purpleAccent
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          category["icon"],
                          size: 35,
                          color: isSelected
                              ? Colors.white
                              : Colors.black,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category["name"],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // Product Grid
          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(
              child: Text(
                "No Products Found",
                style: TextStyle(fontSize: 18),
              ),
            )
                : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .50,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ProductDetailPage(product: product),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image + badges
                        SizedBox(
                          height: 400,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(15),
                                ),
                                child: Image.asset(
                                  product.image,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              // Rating badge
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius:
                                    BorderRadius.circular(8),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                      SizedBox(width: 3),
                                      Text(
                                        "4.8",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Discount badge
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                    BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    "20% OFF",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Details
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                // Best Seller badge
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius:
                                    BorderRadius.circular(6),
                                  ),
                                  child: const Text(
                                    "BEST SELLER",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Text(
                                  product.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  product.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 12,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                const Text(
                                  "Free Delivery",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                // Price row
                                Row(
                                  children: [
                                    Text(
                                      "₹${product.price}",
                                      style: const TextStyle(
                                        color: Colors.pink,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "₹999",
                                      style: TextStyle(
                                        decoration:
                                        TextDecoration.lineThrough,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),



                                // Cart + Wishlist row
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.purpleAccent,
                                        ),
                                        onPressed: () {
                                          Provider.of<CartProvider>(
                                            context,
                                            listen: false,
                                          ).addToCart(product);

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "${product.name} added to cart",
                                              ),
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.shopping_cart,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                        label: const Text(
                                          "Cart",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 8),

                                    Consumer<WishlistProvider>(
                                      builder:
                                          (context, wishlist, child) {
                                        return InkWell(
                                          onTap: () {
                                            wishlist
                                                .toggleWishlist(product);
                                          },
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor:
                                            Colors.purple.shade50,
                                            child: Icon(
                                              wishlist.isInWishlist(
                                                  product)
                                                  ? Icons.favorite
                                                  : Icons
                                                  .favorite_border,
                                              color: Colors.red,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}