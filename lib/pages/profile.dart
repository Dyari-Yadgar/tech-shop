import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_shop/Auth/signup.dart';
import 'package:tech_shop/widgetstyle.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String userName = '';
  String email = '';

  TextEditingController emailController = TextEditingController();
  TextEditingController username = TextEditingController();
  bool isEdit = false;

  // Asynchronous method to get data from SharedPreferences
  getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String savedUserName = pref.getString('Username') ?? '';
    email = pref.getString('email') ?? '';

    // Use setState to update the UI after fetching the data
    setState(() {
      userName =
          savedUserName; // If there's no username, default to empty string
    });
  }

  @override
  void initState() {
    super.initState();
    getData(); // Call getData when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            width: size.width,
            height: size.height / 2,
            decoration: BoxDecoration(),
            child: Stack(
              children: [
                Container(
                  width: size.width,
                  height: size.height / 2 - 50,
                  color: WidgetStyle.primary,
                ),
                Positioned.fill(
                    top: 10,
                    child: SizedBox(
                      height: size.height / 2 - 70,
                      width: size.width,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  // ignore: deprecated_member_use
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(child: SizedBox()),
                              Text(
                                'My Profile',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                ),
                              ),
                              Expanded(child: SizedBox()),
                              SizedBox(
                                width: 35,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Icon(
                              Icons.person_4,
                              color: Colors.white,
                              size: 100,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          // Display the username here
                          Text(
                            userName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 45,
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          Container(
              width: size.width,
              height: size.height * 0.456,
              decoration: BoxDecoration(
                  color: WidgetStyle.primary,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(45))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 25),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: SizedBox()),
                        SizedBox(
                          height: 30,
                          width: 30,
                        ),
                        Text(
                          'info',
                          style: TextStyle(color: Colors.white, fontSize: 35),
                        ),
                        Expanded(child: SizedBox()),
                        SizedBox(
                            height: 30,
                            width: 30,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  isEdit = !true;
                                });
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 35,
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          ' : Account name  $userName',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Expanded(
                            child: TextFormField(
                          enabled: isEdit,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          controller: UsernameController,
                        )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          ' : Email ',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Expanded(
                            child: TextFormField(
                          enabled: isEdit,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          controller: emailController,
                        )),
                      ],
                    ),
                  ],
                ),
              )),
          Visibility(
            child: TextButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: WidgetStyle.white),
              onPressed: () {},
              child: Text('press'),
            ),
          )
        ],
      ),
    ));
  }
}
