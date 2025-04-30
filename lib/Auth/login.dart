import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tech_shop/Auth/signup.dart';
import 'package:tech_shop/main.dart';
import 'package:tech_shop/WidgetStyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tech_shop/Auth/forgotpassword.dart';
import 'package:tech_shop/pages/admin-pages/admindashboard.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future<void> signInWithGoogle() async {
    setState(() {
      isLogin = true;
    });

    // Trigger Google Sign-In
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    if (googleAuth == null) return;

    // Create credentials for Firebase using the Google authentication tokens
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with the Google credentials
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User user = userCredential.user!;

    // Check if the user document already exists in Firestore
    final userDoc =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    final docSnapshot = await userDoc.get();

    if (!docSnapshot.exists) {
      // If the document doesn't exist, create a new user document with role = 'user'
      await userDoc.set({
        'name': user.displayName ?? '',
        'email': user.email,
        'history': [],
        'favorites': [],
        'role': 'user', // Default role is 'user'
      });
    }

    if (!mounted) return;

    // Navigate to the BottomNavigation screen after successfully logging in
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => BottomNavigation()));
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  GlobalKey<FormFieldState<String>> emailValid = GlobalKey();
  GlobalKey<FormFieldState<String>> passValid = GlobalKey();
  bool isLogin = false;
  bool isPassHide = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Tech Shop',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: WidgetStyle.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
      ),
      body: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: size.height * 0.30,
                child: Image.asset('assets/images/logo.jpg'),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: TextFormField(
                  controller: emailController,
                  validator: (value) {
                    return value != null &&
                            (!value.contains('@') ||
                                value[0] == '@' ||
                                value[value.length - 1] == '@')
                        ? 'Wrong email address'
                        : null;
                  },
                  key: emailValid,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    suffixIcon: Icon(
                      Icons.email,
                      color: WidgetStyle.primary,
                    ),
                    focusedBorder: Border(),
                    enabledBorder: Border(),
                    errorBorder: Border(),
                    disabledBorder: Border(),
                    focusedErrorBorder: Border(),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: TextFormField(
                  controller: passController,
                  validator: (value) => value != null && value.length < 6
                      ? 'it must be at least 6 characters long'
                      : null,
                  key: passValid,
                  obscureText: isPassHide,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPassHide = !isPassHide;
                          });
                        },
                        icon: Icon(
                          isPassHide ? Icons.visibility : Icons.visibility_off, color: WidgetStyle.primary,
                        )),
                    focusedBorder: Border(),
                    enabledBorder: Border(),
                    errorBorder: Border(),
                    disabledBorder: Border(),
                    focusedErrorBorder: Border(),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: WidgetStyle.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )),
                            onPressed: () async {
                              if (emailValid.currentState!.validate() &&
                                  passValid.currentState!.validate() &&
                                  !isLogin) {
                                try {
                                  setState(() {});
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passController.text,
                                  )
                                      .then((value) async {
                                    if (FirebaseAuth
                                        .instance.currentUser!.emailVerified) {
                                      final uid = FirebaseAuth
                                          .instance.currentUser!.uid;
                                      final userDoc = await FirebaseFirestore
                                          .instance
                                          .collection('users')
                                          .doc(uid)
                                          .get();

                                      final role = userDoc.data()?['role'];

                                      if (role == 'admin') {
                                        Navigator.pushReplacement(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                AdminDashboard(),
                                          ),
                                        );
                                      } else {
                                        Navigator.pushReplacement(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                BottomNavigation(),
                                          ),
                                        );
                                      }
                                    } else {
                                      FirebaseAuth.instance.signOut;
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Email Not Verified"),
                                            content: Text(
                                                "Please check your email inbox and verify your account."),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {});
                                                  Navigator.of(context).pop();
                                                  FirebaseAuth.instance
                                                      .signOut();
                                                },
                                                child: Text("OK"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  });
                                } on FirebaseAuthException catch (e) {
                                  if (!mounted) return;

                                  String errorMessage =
                                      "Username or Password is wrong";
                                  if (e.code == 'email-already-in-use') {
                                    errorMessage =
                                        "The email is already in use.";
                                  }
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("Error"),
                                      content: Text(errorMessage),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("OK"),
                                        ),
                                      ],
                                    ),
                                  );
                                } catch (e) {
                                  print("Error during account creation: $e");
                                }
                              }
                            },
                            child: isLogin
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ))),
                  ),
                  IconButton(
                      onPressed: () {
                        signInWithGoogle();
                      },
                      icon: Image.asset('assets/images/google.png'))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => ForgotPassword(),
                        ));
                  },
                  child: Text(
                    'Forgot your password?',
                    style: TextStyle(color: WidgetStyle.primary),
                  )),
              Expanded(child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'do not have account?',
                        style: TextStyle(color: Colors.black),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => Signup(),
                            ));
                      },
                      child: Text(
                        'Create Account',
                        style: TextStyle(color: WidgetStyle.primary),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  OutlineInputBorder Border() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: WidgetStyle.primary, width: 2),
      borderRadius: BorderRadius.circular(20),
    );
  }
}
