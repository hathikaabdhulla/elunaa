import 'package:elunaa/profile/trackorder.dart';
import 'package:elunaa/screen/home.dart';
import 'package:flutter/material.dart';

class OrderItem {
  final String image;
  final String name;
  final String price;
  final String status;
  final DateTime date;

  OrderItem({
    required this.image,
    required this.name,
    required this.price,
    required this.status,
    required this.date,
  });

  String get formattedDate {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return "${date.day} ${months[date.month - 1]} ${date.year}";
  }
}

// ---------------- ORDER STORE ----------------
// Intha class thaan app full-a orders-ah store pannum.
// Order place panna appo, evide irundhaalum,
// OrderStore.instance.addOrder(...) nu call pannina podhum,
// automatic-a Orders page refresh aagi antha order display aagum.
class OrderStore extends ChangeNotifier {
  OrderStore._internal();
  static final OrderStore instance = OrderStore._internal();

  final List<OrderItem> _orders = []; // Start empty — no dummy data

  List<OrderItem> get orders => List.unmodifiable(_orders);

  void addOrder(OrderItem order) {
    _orders.insert(0, order); // Latest order mela varum
    notifyListeners();
  }
}

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final TextEditingController searchController = TextEditingController();

  List<OrderItem> filteredOrders = [];
  String selectedDateFilter = "Last 3 months";
  String searchText = "";

  @override
  void initState() {
    super.initState();
    // OrderStore la maatram (new order add aana udane) refresh aaga listen pannurom
    OrderStore.instance.addListener(_onOrdersChanged);
    filteredOrders = _applySearch(_filterByDate(selectedDateFilter));
  }

  @override
  void dispose() {
    OrderStore.instance.removeListener(_onOrdersChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onOrdersChanged() {
    setState(() {
      filteredOrders = _applySearch(_filterByDate(selectedDateFilter));
    });
  }

  List<OrderItem> _filterByDate(String dateFilter) {
    final allOrders = OrderStore.instance.orders;
    final now = DateTime.now();
    if (dateFilter == "Last 30 days") {
      return allOrders.where((o) => now.difference(o.date).inDays <= 30).toList();
    } else if (dateFilter == "Last 3 months") {
      return allOrders.where((o) => now.difference(o.date).inDays <= 90).toList();
    } else if (dateFilter == "2026") {
      return allOrders.where((o) => o.date.year == 2026).toList();
    } else if (dateFilter == "2025") {
      return allOrders.where((o) => o.date.year == 2025).toList();
    } else if (dateFilter == "2024") {
      return allOrders.where((o) => o.date.year == 2024).toList();
    }
    return List.from(allOrders);
  }

  List<OrderItem> _applySearch(List<OrderItem> source) {
    if (searchText.trim().isEmpty) return source;
    return source
        .where((o) => o.name.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }

  void applyFilter(String dateFilter) {
    setState(() {
      selectedDateFilter = dateFilter;
      filteredOrders = _applySearch(_filterByDate(dateFilter));
    });
  }

  void onSearchChanged(String value) {
    setState(() {
      searchText = value;
      filteredOrders = _applySearch(_filterByDate(selectedDateFilter));
    });
  }

  Future<void> openFilterPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilterPage(currentFilter: selectedDateFilter),
      ),
    );

    // "Apply" on FilterPage pops back with the chosen date filter (or null if Back was pressed)
    if (result != null && result is String) {
      applyFilter(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade200,
        centerTitle: true,
        title: const  Text(
          "My Orders",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child:Column(
        children: [
          // Search bar + Filter (matches screenshot 1's top row)
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: onSearchChanged,
                      decoration: const InputDecoration(
                        hintText: "Search all orders",
                        prefixIcon: Icon(Icons.search, color: Colors.pink),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: openFilterPage,
                  child: const Row(
                    children: [
                      Text(
                        "Filter",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: filteredOrders.isEmpty
                ? emptyOrdersView()
                : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children:
              filteredOrders.map((o) => orderCard(context, o)).toList(),
            ),
          ),
        ],
      ),
      ),
    );
  }

  // Matches screenshot 2 — "haven't placed an order" empty state
  Widget emptyOrdersView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Purchase history",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(selectedDateFilter, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 30),
          const Center(
            child: Text(
              "Looks like you haven't placed an order in this period.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              "You have reached the end of Your Orders",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget orderCard(BuildContext context, OrderItem order) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    order.image,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.name,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        order.price,
                        style: const TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.local_shipping, color: Colors.green, size: 18),
                          const SizedBox(width: 5),
                          Text(
                            order.status,
                            style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Ordered on ${order.formattedDate}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 25),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent),
                    onPressed: () {                      Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TrackingPage(),
                      ),

                    );
                      // Order Details Page
                    },
                    icon: const Icon(Icons.visibility),
                    label: const Text("view detail"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),

                      );
                    },
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text("return to home"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- FILTER PAGE ----------------
// Matches screenshot 1: order-type radios, order-date radios, Apply button.

class FilterPage extends StatefulWidget {
  final String currentFilter;
  const FilterPage({super.key, required this.currentFilter});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String orderType = "Orders";
  late String dateFilter;

  final List<String> dateOptions = [
    "Last 30 days",
    "Last 3 months",
    "2026",
    "2025",
    "2024",
  ];

  @override
  void initState() {
    super.initState();
    dateFilter = widget.currentFilter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context), // no result -> no change
                    child: const Row(
                      children: [
                        Icon(Icons.chevron_left),
                        Text("Back", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, dateFilter),
                    child: const Text("Apply"),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            sectionHeader("FILTER BY ORDER TYPE"),
            radioTile(
              label: "Orders",
              value: "Orders",
              groupValue: orderType,
              onChanged: (v) => setState(() => orderType = v!),
            ),
            radioTile(
              label: "Not Yet Shipped",
              value: "Not Yet Shipped",
              groupValue: orderType,
              onChanged: (v) => setState(() => orderType = v!),
            ),

            sectionHeader("FILTER BY ORDER DATE"),
            ...dateOptions.map(
                  (option) => radioTile(
                label: option,
                value: option,
                groupValue: dateFilter,
                onChanged: (v) => setState(() => dateFilter = v!),
              ),
            ),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  onPressed: () => Navigator.pop(context, dateFilter),
                  child: const Text("Apply", style: TextStyle(color: Colors.black87)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionHeader(String text) {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade100,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
      ),
    );
  }

  Widget radioTile({
    required String label,
    required String value,
    required String groupValue,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      children: [
        RadioListTile<String>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: Colors.blue,
          title: Text(label, style: const TextStyle(fontSize: 16)),
        ),
        const Divider(height: 1),
      ],

    );
  }
}