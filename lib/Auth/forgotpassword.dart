import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_shop/Auth/login.dart';
import 'package:tech_shop/widgetstyle.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  GlobalKey<FormFieldState<String>> emailValid = GlobalKey();
  GlobalKey<FormFieldState<String>> passValid = GlobalKey();

  TextEditingController emailController = TextEditingController();
  bool isSend = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
          ),
          centerTitle: true,
          title: Text(
            'Add New Item',
            style: TextStyle(color: WidgetStyle.white),
          ),
          backgroundColor: WidgetStyle.primary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: size.height * 0.40,
                child: Image.asset('assets/images/logo.jpg'),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Expanded(
                  child: TextFormField(
                    controller: emailController,
                    key: emailValid,
                    validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return 'Email must contain @';
                      }

                      if (!value.endsWith('.com')) {
                        return 'Email must end with .com';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter the email',
                      fillColor: Colors.grey,
                      suffix: Icon(
                        Icons.email,
                        color: WidgetStyle.primary,
                      ),
                      focusedBorder: Border(),
                      enabledBorder: Border(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: WidgetStyle.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                      onPressed: () async {
                        if (emailValid.currentState!.validate() && !isSend) {
                          setState(() {
                            isSend = !isSend;
                          });
                          showDialog(
                            // ignore: use_build_context_synchronously
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Link sent"),
                                content: Text(
                                    "Please check your email inbox and reset your password (if the email exists)"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {});
                                      Navigator.of(context).pop();
                                      Navigator.pushReplacement(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) => Login(),
                                          ));
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: isSend
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Send',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ))),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
OutlineInputBorder Border() {
  return OutlineInputBorder(
    borderSide: BorderSide(color: WidgetStyle.primary, width: 2),
    borderRadius: BorderRadius.circular(20),
  );
}

Future<bool> doesEmailExist(String email) async {
  // ignore: deprecated_member_use
  final methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

  if (methods.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}
