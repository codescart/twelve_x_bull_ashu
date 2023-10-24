import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:twelve_x_bull/otp.dart';
import 'package:twelve_x_bull/register_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'contant/upiconstant.dart';

class Login_Page extends StatefulWidget {
  static String verify = "";

  const Login_Page({Key? key}) : super(key: key);

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  TextEditingController mobile = TextEditingController();
  final _globalkey = GlobalKey<FormState>();
  var phone = "";
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    final size= MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff272139),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(height: size.height/22,),
                Image.asset('assets/images/applogo.png',width: 200,),
                SizedBox(height: size.height/18,),
                Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 50),
                ),
                SizedBox(height: size.height/16,),
                Text(
                  'Please enter the details below to continue',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                SizedBox(height: 8,),
                Form(
                  key: _globalkey,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter no';
                      } else if (value.length != 10) {
                        return 'Please enter 10 digit no';
                      }
                      return null;
                    },
                    controller: mobile,
                    onChanged: (value) {
                      phone = value;
                    },
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    cursorColor: Colors.white,
                    decoration: getInputDecoration(
                        'Mobile Number', Icons.phone_android),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xffd2b086), Color(0xff594f43)]),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2, color: Colors.white),
                  ),
                  child: OutlinedButton(
                      onPressed: () {
                        if (_globalkey.currentState!.validate()) {
                          _userlogin(mobile.text);
                        }
                      },
                      child: Text('Send OTP',
                          style: TextStyle(fontSize: 25, color: Colors.white))),
                ),
                SizedBox(height: size.height/8,),
                Text(
                  "To Contact With Us ! ",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                    onTap: (){
                      _launchCaller();
                    },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Image.asset('assets/images/phone.gif'),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        openwhatsapp();
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Image.asset('assets/images/whatsapp.gif'),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        _launchEmail();
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Image.asset('assets/images/gmail.gif'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration getInputDecoration(String hintext, IconData iconData) {
    return InputDecoration(
      counter: Offstage(),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Color(0xFFF65054)),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Color(0xFFF65054)),
      ),
      filled: true,
      prefixText: '+91 ',
      prefixStyle: TextStyle(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
      suffixIcon: Icon(
        iconData,
        color: Color(0xFFebd197),
      ),
      hintStyle: TextStyle(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
      hintText: hintext,
      // fillColor: kBackgroundColor,
      contentPadding: EdgeInsets.only(left: 15),
    );
  }

  _userlogin(
    String mobile,
  ) async {
    setState(() {
      _loading == true;
    });
    final response = await http.post(
      Uri.parse(AppUrl.usersLogin),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"phone": mobile}),
    );

    var data = jsonDecode(response.body);
    print(data);
    if (data["success"] == "200") {
      final userid = data["data"]["id"];
      // final otp = data["otp"];
      setState(() {
        _loading == false;
      });
      Fluttertoast.showToast(
          msg: "OTP Send Successfull",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          backgroundColor: Colors.green,
          fontSize: 16.0);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  OTPScreens(phoneNo: mobile, userId: userid,)));
    } else {
      setState(() {
        _loading == false;
      });
      Fluttertoast.showToast(
          msg: "This number does not exist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          backgroundColor: Colors.red,
          fontSize: 16.0);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Register_Page(phoneNo:mobile,)));
      print("Error");
    }
  }






  openwhatsapp() async{
    var whatsapp ="+919958617763";
    var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=hello";
    var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("hello")}";

    if( await canLaunch(whatsappURl_android)){
      await launch(whatsappURl_android);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: new Text("whatsapp not installed")));

    }


  }
  _launchCaller() async {
    const url = "tel:9958617763";
    if (await canLaunch(url)) {
      await launch(url);
    } else    {
      throw 'Could not launch $url';
    }
  }

  String email="12xbull.com@gmail.com";
  _launchEmail() async {
    if (await canLaunch("mailto:$email")) {
      await launch("mailto:$email");
    } else {
      throw 'Could not launch';
    }
  }
}
