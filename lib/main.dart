import 'package:flutter/material.dart';
import 'package:tech_shop/WidgetStyle.dart';
import 'package:tech_shop/pages/checkOut.dart';
import 'package:tech_shop/pages/profile.dart';
import 'pages/homepage2.dart';
import 'pages/favorite.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// kota danashm lera krdwaaaaaaa
// gorankarim lerada krdw

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var a = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tech Shop',
      theme: ThemeData(
        fontFamily: 'kurdish',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BottomNavigation(),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  static int pageindex = 1;
  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  List pages = [favorite(), HomePage2(), checkOut()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Tech Shop',
          style: TextStyle(
            color: WidgetStyle.white,
          ),
        ),
        backgroundColor: WidgetStyle.primary,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.white,
        child: Profile(),
      ),
      body: pages.elementAt(BottomNavigation.pageindex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: 'Cards'),
        ],

        //bo rangkrdne aw pageay ka lasaret
        selectedItemColor: WidgetStyle.primary,
        // unselectedItemColor: Colors.amber,
        unselectedItemColor: WidgetStyle.primary.withOpacity(0.2),
        currentIndex: BottomNavigation.pageindex,

        onTap: (value) {
          setState(() {
            BottomNavigation.pageindex = value;
          });
        },
      ),
    ));
  }
}
