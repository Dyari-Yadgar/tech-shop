import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_shop/Auth/login.dart';
import 'package:tech_shop/Auth/signup.dart';
import 'package:tech_shop/main.dart';
import 'package:tech_shop/pages/admin-pages/users/pcbuildoption.dart';
import 'package:tech_shop/pages/user-pages/aboutapp.dart';
import 'package:tech_shop/pages/user-pages/aboutus.dart';
import 'package:tech_shop/pages/user-pages/contactus.dart';
import 'package:tech_shop/pages/user-pages/history.dart';
import 'package:tech_shop/pages/user-pages/pcbuild.dart';
import 'package:tech_shop/pages/user-pages/profile.dart';
import 'package:tech_shop/widgetstyle.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  
  Future<bool> checkUserExists() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    return doc.exists;
  }

  void showLoginSignupDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("First you need to log in or sign up"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  context, CupertinoPageRoute(builder: (_) => Login()));
            },
            child: Text(
              "Login",
              style: TextStyle(color: WidgetStyle.primary),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context, CupertinoPageRoute(builder: (_) => Signup()));
            },
            child: Text("Signup", style: TextStyle(color: WidgetStyle.primary)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
          ),
          centerTitle: true,
          title: Text(
            'Tech Shop',
            style: TextStyle(color: WidgetStyle.white),
          ),
          backgroundColor: WidgetStyle.primary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: double.infinity,
                height: size.height * 0.25,
                child: Image.asset('assets/images/logo.jpg')),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.settings,
                        color: WidgetStyle.primary, size: 20),
                    onPressed: () async {
                      if (await checkUserExists()) {
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (_) => Profile()));
                      } else {
                        showLoginSignupDialog();
                      }
                    },
                  ),
                  TextButton(
                    onPressed: () async {
                      if (await checkUserExists()) {
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (_) => Profile()));
                      } else {
                        showLoginSignupDialog();
                      }
                    },
                    child: Text('Profile Settings',
                        style: TextStyle(
                            color: WidgetStyle.primary, fontSize: 18)),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(FontAwesomeIcons.computer,
                        color: WidgetStyle.primary, size: 20),
                    onPressed: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (_) => PcBuildOption()));
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (_) => PcBuildOption()));
                    },
                    child: Text('Custom Pc Build',
                        style: TextStyle(
                            color: WidgetStyle.primary, fontSize: 18)),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(FontAwesomeIcons.history,
                        color: WidgetStyle.primary, size: 20),
                    onPressed: () async {
                      if (await checkUserExists()) {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => History()));
                      } else {
                        showLoginSignupDialog();
                      }
                    },
                  ),
                  TextButton(
                    onPressed: () async {
                      if (await checkUserExists()) {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => History()));
                      } else {
                        showLoginSignupDialog();
                      }
                    },
                    child: Text('Order History',
                        style: TextStyle(
                            color: WidgetStyle.primary, fontSize: 18)),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              child: Row(
                children: [
                  IconButton(
                    icon:
                        Icon(Icons.group, color: WidgetStyle.primary, size: 20),
                    onPressed: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => AboutUs()));
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => AboutUs()));
                    },
                    child: Text('About Us',
                        style: TextStyle(
                            color: WidgetStyle.primary, fontSize: 18)),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: FaIcon(Icons.info_outline,
                        color: WidgetStyle.primary, size: 20),
                    onPressed: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => AboutApp()));
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => AboutApp()));
                    },
                    child: Text('About Staff',
                        style: TextStyle(
                            color: WidgetStyle.primary, fontSize: 18)),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: FaIcon(Icons.support_agent_outlined,
                        color: WidgetStyle.primary, size: 20),
                    onPressed: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => ContactUs()));
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) => ContactUs()));
                    },
                    child: Text('Contact Us',
                        style: TextStyle(
                            color: WidgetStyle.primary, fontSize: 18)),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.logout,
                        color: WidgetStyle.primary, size: 20),
                    onPressed: () async {
                      if (FirebaseAuth.instance.currentUser != null) {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushReplacement(
                            CupertinoPageRoute(
                                builder: (_) => BottomNavigation()));
                      }
                    },
                  ),
                  TextButton(
                    onPressed: () async {
                      if (FirebaseAuth.instance.currentUser != null) {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushReplacement(
                            CupertinoPageRoute(
                                builder: (_) => BottomNavigation()));
                      }
                    },
                    child: Text('Logout',
                        style: TextStyle(
                            color: WidgetStyle.primary, fontSize: 18)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menuItem(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return Row(
      children: [
        IconButton(
          icon: Icon(icon, color: WidgetStyle.primary, size: 20),
          onPressed: onTap,
        ),
        TextButton(
          onPressed: onTap,
          child: Text(label,
              style: TextStyle(color: WidgetStyle.primary, fontSize: 18)),
        ),
      ],
    );
  }
}
