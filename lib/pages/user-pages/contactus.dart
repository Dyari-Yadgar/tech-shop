import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tech_shop/widgetstyle.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  final String fbUrl =
      "https://www.facebook.com/share/16XJ2Jj3V1/?mibextid=wwXIfr";
  final String instaUrl =
      "https://www.instagram.com/nano.technology.suli?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw==";
  final String tiktokUrl =
      "https://www.tiktok.com/@nano.technology.suli?is_from_webapp=1&sender_device=pc";

  final String whatsappUrl = "https://wa.me/+9647706993542";

  final String telegramUrl = "https://t.me/@dyari21";
  final String phoneNumber = "tel:+9647706993542";

  Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Our Socials",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: WidgetStyle.primary,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => launchURL(fbUrl),
                    child: Icon(Icons.facebook, color: Colors.blue, size: 40),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () => launchURL(instaUrl),
                    child: Icon(Icons.camera_alt, color: Colors.pink, size: 40),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () => launchURL(tiktokUrl),
                    child:
                        Icon(Icons.music_note, color: Colors.black, size: 40),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                "Contacts via",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: WidgetStyle.primary,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => launchURL(whatsappUrl),
                    child: FaIcon(FontAwesomeIcons.whatsapp,
                        color: Colors.green, size: 40),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () => launchURL(phoneNumber),
                    child:
                        Icon(Icons.phone, color: WidgetStyle.primary, size: 40),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () => launchURL(telegramUrl),
                    child: Icon(Icons.chat_bubble,
                        color: WidgetStyle.primary, size: 40),
                  ),
                  SizedBox(width: 20),
                  
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
