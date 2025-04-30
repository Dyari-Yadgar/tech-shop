import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_shop/Auth/login.dart';
import 'package:tech_shop/Auth/signup.dart';
import 'package:tech_shop/WidgetStyle.dart';
import 'package:tech_shop/pages/admin-pages/admindashboard.dart';
import 'package:tech_shop/pages/splash.dart';
import 'package:tech_shop/pages/user-pages/checkOut.dart';
import 'package:tech_shop/pages/user-pages/menu.dart';
import 'pages//user-pages/homepage2.dart';
import 'pages//user-pages/favorite.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await ProviderInstaller.installProviders();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // runApp(const MyApp());
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
  );
}

FirebaseAuth instance = FirebaseAuth.instance;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: Future.value(instance.currentUser),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        if (snapshot.data == null) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SafeArea(
              child: Scaffold(
                body: BottomNavigation(),
              ),
            ),
          );
        }

        // check user rol
        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(snapshot.data!.uid)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: SafeArea(
                  child: Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  ),
                ),
              );
            }

            if (!snapshot.data!.exists) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: SafeArea(
                  child: Scaffold(
                    body: BottomNavigation(),
                  ),
                ),
              );
            }
            if (snapshot.hasError ||
                !snapshot.hasData ||
                !snapshot.data!.exists) {
              return MaterialApp(
                  home: SafeArea(
                child: Scaffold(
                  body: Center(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You need to log in to continue",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => Login()),
                                  );
                                },
                                icon: Icon(Icons.login),
                                label: Text("Login"),
                                style: ElevatedButton.styleFrom(
                                  iconColor: WidgetStyle.primary,
                                  textStyle: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(width: 20),
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => Signup()),
                                  );
                                },
                                icon: Icon(Icons.app_registration),
                                label: Text("Signup"),
                                style: ElevatedButton.styleFrom(
                                  textStyle: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
            }

            final data = snapshot.data!.data() as Map<String, dynamic>;
            final role = data['role'];

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Tech Shop',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: role == 'admin' ? AdminDashboard() : BottomNavigation(),
            );
          },
        );
      },
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
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Tech Shop',
          style: TextStyle(
            color: WidgetStyle.white,
          ),
        ),
        backgroundColor: WidgetStyle.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            iconSize: 35,
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),

      // am code'a optimize krawa la shweneki trda boya hamisha role user'a
      drawer: Drawer(
          backgroundColor: Colors.white,
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(instance.currentUser?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || !snapshot.data!.exists) {
                return Menu();
              }

              var userRole = snapshot.data!.get('role');

              if (userRole == null) {
                return Menu();
              }

              if (userRole == 'admin') {
                return Text("");
              } else {
                return Menu();
              }
            },
          )),
      body: pages.elementAt(BottomNavigation.pageindex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: 'Cards'),
        ],
        selectedItemColor: WidgetStyle.primary,
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
