import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twelve_x_bull/bottom_navbar.dart';
import 'package:twelve_x_bull/contant/upiconstant.dart';
import 'package:twelve_x_bull/home/home_page.dart';
import 'package:twelve_x_bull/login_page.dart';
import 'package:twelve_x_bull/otp.dart';
import 'package:twelve_x_bull/profile/profile_page.dart';
import 'package:twelve_x_bull/profile/setting_page.dart';
import 'package:twelve_x_bull/transaction/PrivacyPolicy.dart';
import 'package:twelve_x_bull/transaction/TermsCondition.dart';

class Drawer_Page extends StatefulWidget {
  const Drawer_Page({Key? key}) : super(key: key);

  @override
  State<Drawer_Page> createState() => _Drawer_PageState();
}

class _Drawer_PageState extends State<Drawer_Page> {
  void initState() {
    viewprofile();
    super.initState();
  }

  var map;
  Future viewprofile() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    final response = await http.get(
      Uri.parse(
          AppUrl.baseurl+"get?id=$userid"),
    );
    var data = jsonDecode(response.body);
    print(data);
    print("mmmmmmmmmmmm");
    if (data['success'] == '200') {
      setState(() {
        map = data['data'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [Color(0xffa446f3), Color(0xff2b143e)]),
        ),
        child: ListView(
          children: [
            DrawerHeader(
              child: Image.asset(
                'assets/images/img.png',

              ),
            ), //
            Column(
              children: [
                Text(map==null?'Name':
                  map['name'].toString(),
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                Text(
                map==null?'email':
                  map['email'].toString(),
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),

            // decoration: BoxDecoration(color: Colors.green),
            ListTile(
              title: Text(
                'Home ',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => BottomNavBar()));
              },
              leading: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),

            ListTile(
              title: Text(
                'Terms & Condition',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>TermAndCondition()));
              },
              leading: Icon(
                Icons.terminal,
                color: Colors.white,
              ),
            ),
            ListTile(
              title: Text(
                'Privacy Policy',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PrivacyPolicy()));
              },
              leading: Icon(
                Icons.privacy_tip,
                color: Colors.white,
              ),
            ),
            // ListTile(
            //   title: Text(
            //     'Settings',
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   onTap: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => Setting()));
            //   },
            //   // leading: Icon(
            //   //   Icons.settings,
            //   //   color: Colors.white,
            //   // ),
            // ),
            ListTile(
              title: Text(
                'Log Out',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('userId');
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext ctx) =>Login_Page()));
              },
              leading: Icon(
                Icons.logout_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
