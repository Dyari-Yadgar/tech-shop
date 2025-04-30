import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tech_shop/main.dart';
import 'package:tech_shop/widgetstyle.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0;
  late Timer _timer;
  late String _randomText; // <-- this will hold the random text

  // List of interesting texts
  final List<String> splashTexts = [
    "Discover the future of technology with us!",
    "Upgrade your world with our latest gadgets!",
    "Your next favorite tech is just a tap away!",
    "Innovation starts here. Let's explore!",
    "Bringing the best tech deals to your hands!",
    "Find the perfect gear for your passion!",
    "Get ready to power up your tech life!",
    "Discover the latest tech deals at your fingertips!",
    "Ready to upgrade your gear? Let's make it happen!",
    "Find the best laptops and accessories, curated just for you.",
    "Your next favorite tech product is waiting for you.",
    "Explore new arrivals in the world of gaming tech.",
    "Tech made simple—shop with ease and confidence!",
    "Elevate your tech game with our premium collection.",
    "Get inspired by top-rated laptops and accessories.",
    "We’ve got something special for every tech enthusiast.",
    "Join the future of tech with the latest gadgets.",
    "Upgrade your workspace with cutting-edge tech.",
    "Looking for quality? You’ve come to the right place!",
    "Ready for a new adventure? Check out our top-rated tech!",
    "The perfect gear for your next big project awaits.",
    "Tech that fits your lifestyle. Explore now!",
    "Get ahead of the game with our latest tech innovations.",
    "Find your tech match here—exclusive deals just for you.",
    "Start your journey with the best in technology.",
    "Stay ahead with the latest from your favorite brands.",
    "Your one-stop shop for all things tech.",
  ];

  @override
  void initState() {
    super.initState();

    // Pick a random text
    _randomText = splashTexts[Random().nextInt(splashTexts.length)];

    // Progress timer
    _timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {
        _progress += 0.01;
        if (_progress >= 1.0) {
          _progress = 1.0;
          _timer.cancel();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.jpg'),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: _progress,
                    backgroundColor: Colors.grey[300],
                    color: WidgetStyle.primary,
                    minHeight: 8,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  _randomText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
