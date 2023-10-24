import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twelve_x_bull/contant/upiconstant.dart';
import 'package:twelve_x_bull/transaction/transaction%20history.dart';
class Withdraw extends StatefulWidget {
  const Withdraw({Key? key}) : super(key: key);

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> with TickerProviderStateMixin {


  late TabController _tabController;

  final TextEditingController Upi = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController acname = TextEditingController();
  final TextEditingController ifsc = TextEditingController();
  final _globalkey = GlobalKey<FormState>();

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios,color: Colors.black,),),
        title: Text('Withdraw Cash',style: TextStyle(color: Colors.black),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon( Icons.currency_rupee,
              color: Colors.black,
              size: 25,),
          ),
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
      ),
      bottomNavigationBar: Container(
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
              if (_globalkey.currentState!.validate()) {
                withdrawl(
                    amount.text , name.text,Upi.text,phone.text,acname.text,ifsc.text
                );
              }

            },
            child: Text('Withdraw Request',
                style: TextStyle(
                    fontSize: 15, color: Colors.white))),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text('Enter Amount',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40,right: 60),
              child:   Form(
                key: _globalkey,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Amount';
                    }else if (int.parse(value)<=199) {
                      return 'Please enter minimum 200 rs amount';
                    }
                    return null;
                  },
                  controller: amount,
                 maxLength: 10,
                  style: TextStyle(fontSize: 40),
                  cursorColor: Colors.black,
                  textAlign: TextAlign.center,
                  // cursorHeight: 40,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    counterText: "",
                    hintText: '00',
                    // hintStyle: TextStyle(color: Colors.white,),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
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
                          fontSize: 15, color: Colors.black))),
            ),
            SizedBox(
              height: 10,
            ),
            Text('* Minimum withdrawl Request ₹200 ',
                style: TextStyle(
                    fontSize: 10, color: Colors.black)),
            Text('* 3% platform fee ',
                style: TextStyle(
                    fontSize: 10, color: Colors.black)),

            Container(child:
            Column(
              children:[
              Container(
              height: 60,
              margin: EdgeInsets.only(left: 60),
              child: TabBar(
                indicator: BoxDecoration(
              gradient: LinearGradient(
              colors: [Color(0xffd2b086), Color(0xff594f43)]),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2, color: Colors.grey),
            ),
                tabs: [
                  Container(
                    width: 70.0,
                    child: new Text(
                      'UPI',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    width: 75.0,
                    child:  Text(
                      'Bank',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
                unselectedLabelColor: const Color(0xffacb3bf),
                indicatorColor: Color(0xFFffac81),
                labelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3.0,
                indicatorPadding: EdgeInsets.all(10),
                isScrollable: false,
                controller: _tabController,
              ),
            ),
                Container(
                  height: 500,
                  child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        ///upi
                        Container(

                          // color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Align(
                                    alignment:Alignment.topLeft,
                                    child: Text('Name')),
                                TextFormField(
                                  controller: name,
                                  keyboardType: TextInputType.name,
                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                  // cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.account_circle_outlined,),
                                    hintText: 'Enter Name',
                                    // hintStyle: TextStyle(color: Colors.white),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:  BorderSide(width: 2, color: Colors.black45),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(width: 2, color: Colors.black45),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Align(
                                    alignment:Alignment.topLeft,
                                    child: Text('UPI ID')),
                                TextFormField(
                                  controller: Upi,
                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                  // cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.mobile_screen_share,),
                                    hintText: 'Enter UPI ID',
                                    // hintStyle: TextStyle(color: Colors.white),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:  BorderSide(width: 2, color: Colors.black45),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(width: 2, color: Colors.black45),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20,),

                              ],
                            ),
                          ),
                        ),
                        /// bank
                        Container(
                          // color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                    alignment:Alignment.topLeft,
                                    child: Text('Account Holder Name')),
                                TextFormField(
                                  controller: name,
                                  keyboardType: TextInputType.name,
                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                  // cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.account_circle_outlined,),
                                    hintText: 'Account Holder Name',
                                    // hintStyle: TextStyle(color: Colors.white),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:  BorderSide(width: 2, color: Colors.black45),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(width: 2, color: Colors.black45),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                    alignment:Alignment.topLeft,
                                    child: Text('Account Holder Phone no')),
                                TextFormField(
                                  controller: phone,
                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                  // cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.phone_android_outlined,),
                                    hintText: 'Enter  Phone no',
                                    // hintStyle: TextStyle(color: Colors.white),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:  BorderSide(width: 2, color: Colors.black45),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(width: 2, color: Colors.black45),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                    alignment:Alignment.topLeft,
                                    child: Text('Account Number')),
                                TextFormField(
                                  controller: acname,
                                  keyboardType: TextInputType.name,
                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                  // cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.account_balance_outlined,),
                                    hintText: 'Account Number',
                                    // hintStyle: TextStyle(color: Colors.white),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:  BorderSide(width: 2, color: Colors.black45),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(width: 2, color: Colors.black45),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                    alignment:Alignment.topLeft,
                                    child: Text('IFSC Code')),
                                TextFormField(
                                  controller: ifsc,
                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                  // cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.add_card,),
                                    hintText: 'Enter IFSC Code',
                                    // hintStyle: TextStyle(color: Colors.white),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:  BorderSide(width: 2, color: Colors.black45),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(width: 2, color: Colors.black45),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),

                              ],
                            ),
                          ),
                        ),
                      ]),
                )])

        ),
          ],
        ),
      )
    );
  }

  withdrawl( String amount, String name,String Upi,String phone,String acname,String ifsc ) async {
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");

    final response = await http.post(
      Uri.parse(
          AppUrl.baseurl+"bank_withdrawl"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "user_id": "$userid",
        "Ac_number": acname,
        "ifsc": ifsc,
        "phone": phone,
        "name": name,
        "amount": amount,
        "upi": Upi,
      }),
    );

    var data = jsonDecode(response.body);
    print('pppppppp');
    print(data);
    if (data["success"] == "200") {
      Fluttertoast.showToast(
          msg: data["msg"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          backgroundColor: Colors.green,
          fontSize: 16.0);
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) =>
      //             OTPScreens(phoneNo: mobile, userId: userid)));
    } else {

      Fluttertoast.showToast(
          msg: data["msg"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          backgroundColor: Colors.red,
          fontSize: 16.0);
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => Register_Page(phoneNo:mobile,)));
      print("Error");
    }
  }
}
