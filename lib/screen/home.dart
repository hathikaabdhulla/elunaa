import 'package:elunaa/data/product_data.dart';
import 'package:elunaa/model/product_model.dart';
import 'package:elunaa/pages/category.dart';
import 'package:elunaa/pages/notification.dart';
import 'package:elunaa/pages/old%20categories.dart';
import 'package:elunaa/pages/searchpage.dart';
import 'package:elunaa/profile/profile.dart';
import 'package:elunaa/provider/cart_provider.dart';
import 'package:elunaa/provider/wishlist_provider.dart';
import 'package:elunaa/screen/offerpage.dart';
import 'package:elunaa/screen/product_detail.dart';
import 'package:elunaa/screen/wish_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cart_page.dart';
 // NEW: search results-ah kaatura puthu page

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  String username = "User";

  final TextEditingController searchController = TextEditingController();

  // Search bar la type panra text ah track panna
  String searchText = "";

  List<Map<String, dynamic>> categories = [
    {"name": "All", "icon": Icons.grid_view},
    {"name": "Skin Care", "icon": Icons.spa},
    {"name": "Hair", "icon": Icons.content_cut},
    {"name": "Makeup", "icon": Icons.face},
    {"name": "Perfume", "icon": Icons.local_florist},
    {"name": "Offers", "icon": Icons.local_offer},
  ];

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username") ?? "User";
    });
  }

  void onBottomTap(int index) {
    setState(() {
      selectedIndex = index;
    });

    switch (index) {
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const ShopPage()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const CartPage()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const ProfilePage()));
        break;
    }
  }

  // NEW: search bar la irundhu SearchResultsPage ku navigate panna
  // ithu than common function - onSubmitted and search icon rendume
  // idha than call pannum
  void goToSearchResults(String query) {
    if (query.trim().isEmpty) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SearchResultsPage(query: query),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.purple),
              child: Center(
                child: Text(
                  "Elunaa",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text("Categories"),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ShopPage())),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text("Cart"),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const CartPage())),
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text("Wishlist"),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const WishlistPage())),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ProfilePage())),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  children: [
                    Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Hello",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          Text(
                            username,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications_none),
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => NotificationPage())),
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const WishlistPage())),
                    ),
                    IconButton(
                      icon: const Icon(Icons.shopping_cart_outlined),
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const CartPage())),
                    ),
                  ],
                ),
              ),

              // Search Bar
              // NEW: type pannumbodhu home page grid maaraathu (setState
              // mattum, display ku full productList than use pannuvom).
              // Enter/search press pannina odhane or search icon click
              // pannina odhane puthu SearchResultsPage open aagum.
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: searchController,
                  textInputAction: TextInputAction.search,
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  onSubmitted: (value) {
                    goToSearchResults(value);
                  },
                  decoration: InputDecoration(
                    hintText: "Search Products",
                    prefixIcon: GestureDetector(
                      onTap: () => goToSearchResults(searchText),
                      child: const Icon(Icons.search),
                    ),
                    suffixIcon: const Icon(Icons.mic_none),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Categories",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                height: 95,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const ShopPage())),
                      child: Container(
                        width: 85,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.purple.shade50,
                              child: Icon(
                                categories[index]["icon"],
                                color: Colors.purple,
                                size: 28,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              categories[index]["name"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Offer Banner
              GestureDetector(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) =>  OfferPage())),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  height: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [Colors.purpleAccent, Colors.purple],
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("UP TO",
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                              SizedBox(height: 5),
                              Text(
                                "20% OFF",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "On All Beauty Products",
                                style:
                                TextStyle(color: Colors.white70, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(Icons.local_offer,
                            color: Colors.white, size: 90),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Best Sellers",
                        style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("See All",
                        style: TextStyle(
                            color: Colors.purple, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // Best Seller Grid
              // NEW: ippo idhu eppovume full productList ah than kaatum.
              // Search panradhukaana filtering ellam SearchResultsPage
              // ku maathiyaachu, so home page maara maatathu.
              productList.isEmpty
                  ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Text(
                    "No Products Found",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              )
                  : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: productList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: .62,
                ),
                itemBuilder: (context, index) {
                  final product = productList[index];
                  final wishlistProvider = Provider.of<WishlistProvider>(context);
                  final bool isFav =
                  wishlistProvider.isInWishlist(product);

                  // Provider ah watch pannurom -> cart la add/remove aana ippove
                  // ithu rebuild aagi button automatic ah maarum
                  final cartProvider = Provider.of<CartProvider>(context);

                  // FIX: cartItems (List<CartModel>) la product (Product) irukka nu
                  // neral ah "contains" panna mudiyathu - type different.
                  // Adhaan CartProvider la irukura isInCart() helper ah use pannurom
                  // (product name compare panni sariya check pannum)
                  final bool inCart = cartProvider.isInCart(product);

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailPage(product: product),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade300, blurRadius: 6),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ---- Image + offer badge + fav button ----
                          Expanded(
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(18)),
                                  child: Image.asset(
                                    product.image,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                // Offer badge - top left
                                if (product.offer != null)
                                  Positioned(
                                    left: 8,
                                    top: 8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        product.offer!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),

                                // Favorite button - top right, toggles red
                                Positioned(
                                  right: 8,
                                  top: 8,
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        isFav
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isFav ? Colors.red : Colors.grey,
                                        size: 18,
                                      ),
                                      onPressed: () {
                                        wishlistProvider.toggleWishlist(product);
                                      },
                                    ),
                                  ),
                                ),

                                // Rating badge - bottom left over image
                                Positioned(
                                  left: 8,
                                  bottom: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.star,
                                            color: Colors.amber, size: 13),
                                        const SizedBox(width: 3),
                                        Text(
                                          product.rating.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // ---- Name (big, bold, dark) ----
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 8, 10, 2),
                            child: Text(
                              product.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),

                          // ---- Description (smaller, colorful/purple, light weight) ----
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              product.description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.purple.shade300,
                              ),
                            ),
                          ),

                          const SizedBox(height: 6),

                          // ---- Price ----
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "₹${product.price.toStringAsFixed(0)}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          // ---- Cart button: text/color changes once added ----
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purpleAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  final cartProvider =
                                  Provider.of<CartProvider>(context, listen: false);

                                  if (cartProvider.isInCart(product)) {
                                    // Already cart la irukku -> cart page ku poidum
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const CartPage(),
                                      ),
                                    );
                                  } else {
                                    // Illana cart la add pannidum
                                    cartProvider.addToCart(product);
                                  }
                                  // setState() thevai illa - Provider.of(context) (listen: true)
                                  // watch panrathala automatic ah rebuild aagidum
                                },
                                icon: Icon(
                                  inCart
                                      ? Icons.arrow_forward
                                      : Icons.shopping_cart,
                                  size: 18,
                                ),
                                label: Text(
                                  inCart ? "Go to Cart" : "Add Cart",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: onBottomTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Categories"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Settings"),
        ],
      ),
    );
  }
}