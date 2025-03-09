import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_shop/Auth/signup.dart';
import 'package:tech_shop/WidgetStyle.dart';
import 'package:tech_shop/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  GlobalKey<FormFieldState<String>> emailValid = GlobalKey();
  GlobalKey<FormFieldState<String>> passValid = GlobalKey();
  bool isPassHide = true;
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
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: size.width * 0.3,
              child: Image.asset('assets/images/logo.jpg'),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: emailController,
              validator: (value) {
                return value != null && (!value.contains('@') || value[0] =='@')
                    ? 
                     value![0] == '@' ? 'enter a valid email address' : null : null;
              },
              key: emailValid,
              decoration: InputDecoration(
                  label: Text("Email"),
                  labelStyle: TextStyle(color: WidgetStyle.primary),
                  hintText: "Email",
                  suffix: Icon(
                    Icons.email,
                    color: WidgetStyle.primary,
                  ),
                  focusedBorder: border(),
                  enabledBorder: border(),
                  errorBorder: border(),
                  disabledBorder: border(),
                  focusedErrorBorder: border()),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passwordController,
              validator: (value) => value != null && value.length < 6
                  ? 'The password must be at least 8 characters'
                  : null,
              key: passValid,
              obscureText: true,
              decoration: InputDecoration(
                label: Text("Password"),
                labelStyle: TextStyle(color: WidgetStyle.primary),
                hintText: "Password",
                suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        isPassHide = !isPassHide;
                      });
                    },
                    icon: Icon(
                      ispasshide ? Icons.visibility : Icons.visibility_off,
                      color: WidgetStyle.primary,
                    )),
                focusedBorder: border(),
                enabledBorder: border(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  if(emailValid.currentState!.validate() && passValid.currentState!.validate()){

                  
                    try {
                     await FirebaseAuth.instance.signInWithEmailAndPassword(
                       email: emailController.text,
                        password: passwordController.text,
                      );
                   } catch (e) {
                      print("Error: $e"); // This helps in debugging
                   }
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: WidgetStyle.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextButton(
                onPressed: () {},
                child: Text("forgot Your Password?",
                    style:
                        TextStyle(color: WidgetStyle.primary, fontSize: 15))),
            Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("hasn't account yet?"),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => SignUp(),
                          ));
                    },
                    child: Text("create new account",
                        style: TextStyle(
                            color: WidgetStyle.primary, fontSize: 15))),
              ],
            )
          ],
        ),
      ),
    ));
  }

  OutlineInputBorder border() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: WidgetStyle.primary));
  }
}
