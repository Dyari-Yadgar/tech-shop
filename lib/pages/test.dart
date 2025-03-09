// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class Test extends StatefulWidget {
//   const Test({super.key});

//   @override
//   State<Test> createState() => _TestState();
// }

// class _TestState extends State<Test> {

//   FirebaseFirestore instance = FirebaseFirestore.instance;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: FutureBuilder(
//           future: getData(),
//           builder: (context, snapshot){
//             if(snapshot.connectionState == ConnectionState){
//             }
//             scrollDirection: Axis.vertical;
//           }
          
//         ),
//       ),
//     );
//   }

//   Future<QuerySnapshot> getData(){
//     return instance.collection('users').get();
//   }
// }
