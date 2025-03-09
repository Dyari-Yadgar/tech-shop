import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_shop/Auth/login.dart';
import 'package:tech_shop/WidgetStyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

bool ispasshide = true;
TextEditingController emailController = TextEditingController();
TextEditingController passController = TextEditingController();
TextEditingController UsernameController = TextEditingController();
GlobalKey<FormFieldState<String>> emailValid = GlobalKey();
GlobalKey<FormFieldState<String>> passValid = GlobalKey();

class _SignUpState extends State<SignUp> {
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
              
              decoration: InputDecoration(
                  label: Text("Name"),
                  labelStyle: TextStyle(color: WidgetStyle.primary),
                  hintText: "Name",
                  suffix: Icon(
                    Icons.email,
                    color: WidgetStyle.primary,
                  ),
                  focusedBorder: border(),
                  enabledBorder: border(),
                  errorBorder: border(),
                  focusedErrorBorder: border()),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: emailController,
              validator: (value) => value != null && !value.contains('@')
                  ? 'it must contains (@)'
                  : null,
              key: emailValid,
              decoration: InputDecoration(
                  label: Text("Email Account"),
                  labelStyle: TextStyle(color: WidgetStyle.primary),
                  hintText: "Email Account",
                  suffix: Icon(
                    Icons.person,
                    color: WidgetStyle.primary,
                  ),
                  focusedBorder: border(),
                  enabledBorder: border(),
                  errorBorder: border(),
                  focusedErrorBorder: border()),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passController,
              validator: (value) => value != null && value.length < 8
                  ? 'The password must be at least 8 characters'
                  : null,
              key: passValid,
              obscureText: isPassHide, // ✅ Update obscureText based on state
              decoration: InputDecoration(
                label: Text("Password"),
                labelStyle: TextStyle(color: WidgetStyle.primary),
                hintText: "Password",
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isPassHide = !isPassHide; // ✅ Toggle password visibility
                    });
                  },
                  icon: Icon(
                    isPassHide
                        ? Icons.visibility
                        : Icons.visibility_off, // ✅ Fix variable name
                    color: WidgetStyle.primary,
                  ),
                ),
                focusedBorder: border(),
                enabledBorder: border(),
                errorBorder: border(),
                focusedErrorBorder: border(),
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
                  if (emailValid.currentState!.validate() &&
                      passValid.currentState!.validate()) {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.setString('Username', UsernameController.text);
                    pref.setString('email', emailController.text);
                    pref.setString('password', passController.text);
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => Login()));
                  }
                },
                child: Text(
                  "Create a new account",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: WidgetStyle.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
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
                Text("Do you have your own account?"),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => Login(),
                          ));
                    },
                    child: Text("Log in",
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
