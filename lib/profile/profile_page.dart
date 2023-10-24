import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twelve_x_bull/bottom_navbar.dart';
import 'package:twelve_x_bull/contant/upiconstant.dart';
import 'package:twelve_x_bull/notification.dart';
import 'package:twelve_x_bull/profile/edit_prfile.dart';
import 'package:twelve_x_bull/profile/setting_page.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {

  void initState() {
    viewprofile();
    super.initState();
  }
  var map;
  Future viewprofile() async {
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");
    final response = await http.get(
      Uri.parse(AppUrl.baseurl+"get?id=$userid"),
    );
    var data = jsonDecode(response.body);
    print(data);
    print("mmmmmmmmmmmm");
    if (data['success'] == '200') {
      setState(() {
        map =data['data'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      backgroundColor: Color(0xff272139),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BottomNavBar()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          '12xBull',
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff272139),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => Notification_Page()));
        //       },
        //       icon: Icon(Icons.notifications_none))
        // ],
        bottom: TabBar(
          labelStyle: TextStyle(
            fontSize: 20.0,
          ), //For Selected tab
          unselectedLabelStyle: TextStyle(
            fontSize: 15.0,
          ),
          indicatorColor: Colors.white,
          controller: tabController,
          isScrollable: true,

          labelPadding: EdgeInsets.symmetric(horizontal: 50),
          tabs: [
            Tab(
              child: Text(
                "Profile ",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                "Setting",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 700,
          child: TabBarView(
            controller: tabController,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    child: Container(
                      height: 100,
                      width: 100,
                      // color: Colors.red,
                      child: Image.asset('assets/images/applogo.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Name',
                              style: TextStyle(color: Colors.white),
                            ),
                            map == null
                                ? Text("Your Name")
                                : Text(
                                    map['name'].toString(),
                                    style: TextStyle(color: Colors.white),
                                  )
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.white,
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Phone',
                              style: TextStyle(color: Colors.white),
                            ),
                            map == null
                                ? Text('mobile no')
                                : Text(
                                    map['phone'].toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.white,
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Age',
                              style: TextStyle(color: Colors.white),
                            ),
                            map == null
                                ? Text('Your age')
                                : Text(
                                    map['age'].toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ],
                        ),


                        Divider(
                          thickness: 1,
                          color: Colors.white,
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(color: Colors.white),
                            ),
                            map == null
                                ? Text('your male')
                                : Text(
                                    map['email'].toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.white,
                          height: 40,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfile()));
                            },
                            child: Text("Edit Profile"))
                      ],
                    ),
                  ),
                ],
              ),
              Setting(),
            ],
          ),
        ),
      ),
    );
  }
}
