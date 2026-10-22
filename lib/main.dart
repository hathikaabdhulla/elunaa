import 'package:elunaa/provider/cart_provider.dart';
import 'package:elunaa/provider/theme_provider.dart';
import 'package:elunaa/provider/wishlist_provider.dart';
import 'package:elunaa/screen/home.dart';
import 'package:elunaa/screen/offerpage.dart';
import 'package:elunaa/splash%20screen/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => CartProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => WishlistProvider(),
            ),
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
              ],
      child: const ElunaaApp()
          )
  );
}

class ElunaaApp extends StatelessWidget {
  const ElunaaApp({super.key});

  @override
   Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'ELUNAA',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.purple,
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
      ),

      themeMode: themeProvider.isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}
