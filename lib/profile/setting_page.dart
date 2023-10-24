import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twelve_x_bull/login_page.dart';
import 'package:twelve_x_bull/transaction/PrivacyPolicy.dart';
import 'package:twelve_x_bull/transaction/TermsCondition.dart';
import 'package:url_launcher/url_launcher.dart';
class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff272139),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20,20,20,0),
        child: Column(
          children: [
          //   ListTile(
          //   onTap: (){},
          //   title: Text('Notification',style: TextStyle(color: Colors.white),),
          //   leading: Icon(Icons.notification_add,color: Colors.white,),
          // ),
            ListTile(
              onTap: () async {
                  final String whatsappUrl = "whatsapp://send?phone=+919958617763";
                  if (await canLaunch(whatsappUrl)) {
                    await launch(whatsappUrl);
                  } else {
                    throw 'Could not launch email';
                  }
              },
              title: Text('Support'),
              leading: Icon(Icons.support_agent),
              textColor: Colors.white,
              iconColor: Colors.white,
            ),
            ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>TermAndCondition()));
              },
              title: Text('Terms & Codition'),
              leading: Icon(Icons.question_mark),
              textColor: Colors.white,
              iconColor: Colors.white,
            ),
            ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PrivacyPolicy()));
              },
              title: Text('Policy'),
              leading: Icon(Icons.policy),
              textColor: Colors.white,
              iconColor: Colors.white,
            ),
            ListTile(
              onTap: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                setState(() {
                  prefs.remove('userId');
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext ctx) =>Login_Page()));
                });

              },
              title: Text('Logout'),
              leading: Icon(Icons.logout),
              textColor: Colors.white,
              iconColor: Colors.white,
            ),


          ],
        ),
      ),
    );
  }
}
