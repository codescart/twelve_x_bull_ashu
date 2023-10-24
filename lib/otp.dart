// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously
import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import 'package:twelve_x_bull/bottom_navbar.dart';
import 'package:twelve_x_bull/login_page.dart';


class OTPScreens extends StatefulWidget {
  final String phoneNo;
  final String userId;
  // final String otp;

  const OTPScreens({super.key, required this.phoneNo, required this.userId,});

  @override
  _OTPScreensState createState() => _OTPScreensState();
}

class _OTPScreensState extends State<OTPScreens> {
  final int _otpCodeLength = 6;
  final bool _isLoadingButton = false;
  bool _enableButton = false;

  TextEditingController textEditingController = TextEditingController();

var otp;
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(15.0),
    );
  }
  fetchData() async {
    final response = await http.get(Uri.parse('https://otp.hopegamings.in/send_otp.php?mobile=${widget.phoneNo}&digit=6&mode=live'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      setState(() {
        _startTimer();
        otp = data['otp'];
      });
      print("yyyyyyyyyyyyyy");
      print(otp);
    } else {
      throw Exception('Failed to load data');
    }
  }
  int _counter = 0;
  late Timer _timer;

  _startTimer() {
    _counter = 60; //time counter
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _counter > 0 ? _counter-- : _timer.cancel();
      });
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff272139),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0,left: 20,right: 20,bottom: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 200,
                width: 200,
                child: Image.asset('assets/images/img.png'),
              ), // SizedBox(
              //   height: 20.h,
              // ),.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('OTP Sent to your Phone +91${widget.phoneNo}',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold,color: Colors.white),
                  ),

                  IconButton(
                      color:const Color(0XFF3b9fbe),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const Login_Page()));
                      }, icon:const Icon(Icons.edit)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldPin(
                  textController: textEditingController,
                  autoFocus: true,
                  codeLength: _otpCodeLength,
                  alignment: MainAxisAlignment.center,
                  defaultBoxSize: 40.0,
                  margin: 5,
                  selectedBoxSize: 40.0,
                  textStyle: const TextStyle(fontSize: 20,color: Colors.white),
                  defaultDecoration: _pinPutDecoration.copyWith(
                      border: Border.all(
                      color: Colors.white
                      )),
                  selectedDecoration: _pinPutDecoration,
                  onChange: (code) {
                    if(code.length==6){
                      setState(() {
                        _enableButton=true;
                      });
                    }else{
                      setState(() {
                        _enableButton=false;
                      });
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              if(_enableButton ==true)
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 12,
                  child: InkWell(
                    onTap: () async {
                      debugPrint(textEditingController.text);
                      if(otp==textEditingController.text){
                        final userId = widget.userId;
                        if (userId != 'null') {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setString('userId', userId);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => const BottomNavBar()));
                        }
                      }else{
                        debugPrint('please enter valid otp');
                      }
                    },
                    child: Container(
                      height:45,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0XFF3b9fbe),
                      ),
                      child:_setUpButtonChild(),
                    ),
                  )
              ),
              Text("Can't recived OTP?", style: TextStyle(color: Colors.white),),
              SizedBox(height: 15,),
              _counter < 1
                  ?  Container(
                height: 45,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xffd2b086), Color(0xff594f43)]),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: Colors.white),
                ),
                child: OutlinedButton(
                    onPressed: () {
                      fetchData();
                    },
                    child: Text('Resend OTP',
                        style: TextStyle(fontSize: 15, color: Colors.white))),
              ):Text("Resend OTP in ${_counter.toString().padLeft(2, '0')}", style: TextStyle(color: Colors.white),),
            ],
          ),
        ),
      ),
    );
  }


  Widget _setUpButtonChild() {
    if (_isLoadingButton) {
      return const SizedBox(
        width: 19,
        height: 19,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return  const Text(
        'Verify',
        style: TextStyle(color: Colors.white,
            fontSize: 20,fontWeight: FontWeight.bold),
      );
    }
  }
}


// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:otp_text_field/otp_field.dart';
// import 'package:otp_text_field/style.dart';
// import 'package:twelve_x_bull/bottom_navbar.dart';
// import 'package:twelve_x_bull/login_page.dart';
// import 'package:twelve_x_bull/register_page.dart';
// class Otp_Page extends StatefulWidget {
//   static String verify="";
//
//   const Otp_Page({Key? key}) : super(key: key);
//
//
//   @override
//   State<Otp_Page> createState() => _Otp_PageState();
// }
//
// class _Otp_PageState extends State<Otp_Page> {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   var phone = "";
//   @override
//   Widget build(BuildContext context) {
//     var code = "";
//     return Scaffold(
//       backgroundColor: Color(0xff272139),
//       body: ListView(
//         children: [
//           Center(
//               child: Column(
//                 children: [
//                   Image.asset('assets/images/img.png'),
//                   Text('Login',style: TextStyle(color: Colors.white,fontSize: 50),),
//                   Text('Please enter the details below to continue',
//                     style: TextStyle(color: Colors.grey,fontSize: 15),),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10),
//                     child: Container(
//                       padding: const EdgeInsets.fromLTRB(20,30,0,0),
//                       height: 50,
//                       width: 250,
//                       // color: Colors.red,
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.white,width: 1),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: TextField (
//                         style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
//                         cursorColor: Colors.white,
//                         onChanged: (value){
//                           code=value;
//                         },
//                         maxLength: 6,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//
//                           counter: Offstage(),
//                             border: InputBorder.none,
//                             hintText: 'Enter OTP',
//                           hintStyle: TextStyle(color: Colors.white),
//
//
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(height: 25),
//
//                   Container(
//                     height: 50,
//                     width: 300,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(colors: [Color(0xffd2b086), Color(0xff594f43)]),
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(width: 2,color: Colors.white),
//                     ),
//                     child: OutlinedButton(
//                         onPressed: () async{
//                           try{
//                             PhoneAuthCredential credential = PhoneAuthProvider.credential(
//                                 verificationId: Login_Page.verify, smsCode: code);
//                             // Sign the user in (or link) with the credential
//                             await auth.signInWithCredential(credential);
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>Bottom_Navbar()));
//                           }
//                           catch(e){
//                             print('wrong otp');
//                             final snackbar = SnackBar(content: Text('WRONG OTP'));
//                           }
//                         },
//                         style: OutlinedButton.styleFrom(
//                             side: BorderSide(color: Colors.white),
//                             backgroundColor: Colors.green,
//                             primary: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             )),
//                         child: Text(
//                           'Submit OTP',
//                           style: TextStyle(fontSize: 15,),
//                         )),
//                   ),
//                   SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text("Don't have an Accont ! ",style: TextStyle(color: Colors.white),),
//                       TextButton(onPressed: (){
//                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Register_Page()));
//                       },
//                           child:Text('Register',
//                               style: TextStyle(
//                                   color: Colors.red,
//                                   fontWeight: FontWeight.bold))),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Container(
//                         height: 60,
//                         width: 60,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colors.white,
//                         ),
//                         child: Image.asset('assets/images/phone.gif'),
//                       ),
//                       Container(
//                         height: 60,
//                         width: 60,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Colors.white
//                         ),
//                         child: Image.asset('assets/images/whatsapp.gif'),
//                       ),
//                       Container(
//                         height: 60,
//                         width: 60,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colors.white,
//                         ),
//                         child: Image.asset('assets/images/gmail.gif'),
//
//                       ),
//
//                     ],
//                   )
//
//                 ],
//               )
//           ),
//         ],
//       ),
//     );
//   }
// }
