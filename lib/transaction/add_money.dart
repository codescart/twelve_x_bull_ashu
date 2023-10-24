import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twelve_x_bull/bottom_navbar.dart';
import 'package:twelve_x_bull/contant/upiconstant.dart';
import 'package:twelve_x_bull/notification.dart';
import 'package:twelve_x_bull/transaction/addmoney_page.dart';
import 'package:twelve_x_bull/transaction/withdrawl_page.dart';
import 'package:http/http.dart'as http;
class Add_Money extends StatefulWidget {
  const Add_Money({Key? key}) : super(key: key);

  @override
  State<Add_Money> createState() => _Add_MoneyState();
}

class _Add_MoneyState extends State<Add_Money> {

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
    print("mmmmmmmmmmmmmmm");
    if (data['success'] == '200') {
      setState(() {
        map =data['data'];
        print(map);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '12xBull',
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff272139),
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
        },
          icon: Icon(Icons.arrow_back_ios),),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Notification_Page()));
          }, icon: Icon(Icons.notifications_none))
        ],
      ),
      backgroundColor: Color(0xff272139),
      body:map == null? CircularProgressIndicator():Column(
        children: [
          SizedBox(height: 30,),
          Container(
            height: 200,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white, width: 2),
              gradient: LinearGradient(
                  colors: [Color(0xff302a47), Color(0xff653bb3)]),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'My Money',
                  style: TextStyle(color: Colors.white54, fontSize: 30),
                ),
                map == null || map['wallet'].toString()=="null"
                    ? Text("₹",style: TextStyle(color: Colors.white,fontSize: 40),)
                    : Text(
                  map['wallet'].toString(),
                  style: TextStyle(color: Colors.white , fontSize: 40),
                ),
                Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: OutlinedButton(
                      onPressed: () {},
                      child: Text('100% Safe & Secure',
                          style: TextStyle(
                              fontSize: 15, color: Colors.white))),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 2),
                    gradient: LinearGradient(
                        colors: [Color(0xff302a47), Color(0xff653bb3)]),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Deposit',
                        style: TextStyle(
                            color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        '0',
                        style: TextStyle(
                            color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 2),
                    gradient: LinearGradient(
                        colors: [Color(0xff302a47), Color(0xff653bb3)]),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Bonus',
                        style: TextStyle(
                            color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        map['bouns']=="null"?'00':
                        map['bonus'].toString(),
                        style: TextStyle(
                            color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xffd2b086), Color(0xff594f43)]),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: Colors.white),
                ),
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddMoneyUpi()));
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>UpiPage()));
                    },
                    child: Text('Add Money',
                        style: TextStyle(
                            fontSize: 20, color: Colors.white))),
              ),
              Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xffd2b086), Color(0xff594f43)]),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: Colors.white),
                ),
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Withdraw()));
                    },
                    child: Text('Withdraw Money',
                        style: TextStyle(
                            fontSize: 15, color: Colors.white))),
              ),
            ],
          )
        ],
      ),
    );
  }
}
