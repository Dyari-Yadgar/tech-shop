// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:tech_shop/main.dart';
// import 'package:tech_shop/pages/user-pages/history.dart';
// import 'package:tech_shop/pages/user-pages/pcbuild.dart';
// import 'package:tech_shop/pages/user-pages/profile.dart';
// import 'package:tech_shop/widgetstyle.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class AdminMenu extends StatefulWidget {
//   const AdminMenu({super.key});

//   @override
//   State<AdminMenu> createState() => _AdminMenuState();
// }

// class _AdminMenuState extends State<AdminMenu> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(Icons.arrow_back),
//             color: Colors.white,
//           ),
//           centerTitle: true,
//           title: Text(
//             'Tech Shop',
//             style: TextStyle(
//               color: WidgetStyle.white,
//             ),
//           ),
//           backgroundColor: WidgetStyle.primary,
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
//           ),
//           actions: [
//             SizedBox(
//               width: 40,
//             ),
//             SizedBox(
//               width: 10,
//             ),
//           ],
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: double.infinity,
//               height: size.height * 0.20,
//               child: Image.asset('assets/images/logo.jpg'),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Row(
//               children: [
//                 IconButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           CupertinoPageRoute(
//                             builder: (context) => Profile(),
//                           ));
//                     },
//                     icon: Icon(
//                       Icons.settings,
//                       color: WidgetStyle.primary,
//                       size: 20,
//                     )),
//                 TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           CupertinoPageRoute(
//                             builder: (context) => Profile(),
//                           ));
//                     },
//                     child: Text(
//                       'Profile Settings',
//                       style:
//                           TextStyle(color: WidgetStyle.primary, fontSize: 18),
//                     )),
//               ],
//             ),
//             Row(
//               children: [
//                 IconButton(
//                     onPressed: () {
//                     },
//                     icon: FaIcon(
//                       FontAwesomeIcons.users,
//                       color: WidgetStyle.primary,
//                       size: 20,
//                     )),
//                 TextButton(
//                     onPressed: () {
//                     },
//                     child: Text(
//                       'Users Settings',
//                       style:
//                           TextStyle(color: WidgetStyle.primary, fontSize: 18),
//                     )),
//               ],
//             ),
//             Row(
//               children: [
//                 IconButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           CupertinoPageRoute(
//                             builder: (context) => PcBuild(),
//                           ));
//                     },
//                     icon: FaIcon(
//                       FontAwesomeIcons.computer,
//                       color: WidgetStyle.primary,
//                       size: 20,
//                     )),
//                 TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           CupertinoPageRoute(
//                             builder: (context) => PcBuild(),
//                           ));
//                     },
//                     child: Text(
//                       'Custom Pc Build',
//                       style:
//                           TextStyle(color: WidgetStyle.primary, fontSize: 18),
//                     )),
//               ],
//             ),
//             Row(
//               children: [
//                 IconButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           CupertinoPageRoute(
//                             builder: (context) => PcBuild(),
//                           ));
//                     },
//                     icon: FaIcon(
//                       FontAwesomeIcons.history,
//                       color: WidgetStyle.primary,
//                       size: 20,
//                     )),
//                 TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pushReplacement(
//                         CupertinoPageRoute(
//                             builder: (context) => History()),
//                       );
//                     },
//                     child: Text(
//                       'Orders1',
//                       style:
//                           TextStyle(color: WidgetStyle.primary, fontSize: 18),
//                     )),
//               ],
//             ),
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: () async {
//                     await FirebaseAuth.instance.signOut();
//                     Navigator.of(context).pushReplacement(
//                       CupertinoPageRoute(
//                           builder: (context) => BottomNavigation()),
//                     );
//                   },
//                   icon: Icon(
//                     Icons.logout,
//                     color: WidgetStyle.primary,
//                   ),
//                 ),
//                 TextButton(
//                     onPressed: () async {
//                       await FirebaseAuth.instance.signOut();
//                       Navigator.of(context).pushReplacement(
//                         CupertinoPageRoute(
//                             builder: (context) => BottomNavigation()),
//                       );
//                     },
//                     child: Text(
//                       'Logout',
//                       style:
//                           TextStyle(color: WidgetStyle.primary, fontSize: 18),
//                     )),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }