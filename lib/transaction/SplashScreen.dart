import 'package:flutter/material.dart';
import 'package:twelve_x_bull/bottom_navbar.dart';
import 'package:twelve_x_bull/login_page.dart';

class SplashScreen extends StatefulWidget {
  final String userid;
  const SplashScreen({Key? key,required this.userid}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
            if(widget.userid=="null"){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login_Page()));
            }
            else{
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
            }
          },);// Replace with your main content screen
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff272139),
      body: Center(
        child: Image(image: AssetImage("assets/images/applogo.png"),),
      ),
    );
  }
}
