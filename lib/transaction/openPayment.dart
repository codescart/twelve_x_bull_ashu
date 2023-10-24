
import 'package:flutter/material.dart';
import 'package:twelve_x_bull/bottom_navbar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class UpiWebView extends StatelessWidget {
  final String url;

  UpiWebView({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff272139),
      appBar: AppBar(
        backgroundColor: const Color(0xff272139),
        title: Text('UPI Payment'),
      ),
      floatingActionButton: Container(
        width: 120, // Adjust the width as needed
        height: 50, // Adjust the height as needed
        child: FloatingActionButton(
          onPressed: () {
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: const Color(0xff272139),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back_ios_new_sharp, size: 20,),
              SizedBox(width: 15,),
              Text("Back", style: TextStyle(fontSize: 20),)
            ],
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.le,
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) {
          // Intercept and handle UPI app URLs here
          if (request.url.startsWith('upi://')) {
            launch(request.url);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
