import 'package:flutter/material.dart';



class DoubleTapExitApp extends StatefulWidget {
  @override
  _DoubleTapExitAppState createState() => _DoubleTapExitAppState();
}

class _DoubleTapExitAppState extends State<DoubleTapExitApp> {
  int _tapCount = 0;
  bool _showExitMessage = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_showExitMessage) {
          if (_tapCount == 1) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Press double to exit.'),
            ));
            _tapCount++;
            return false; // Prevent exiting the app.
          } else if (_tapCount == 2) {
            return true; // Allow exiting the app.
          }
        } else {
          setState(() {
            _tapCount = 1;
            _showExitMessage = true;
          });
          Future.delayed(Duration(seconds: 2), () {

            setState(() {
              _tapCount = 0;
              _showExitMessage = false;
            });
          });
          return false; // Prevent exiting the app.
        }
        return false; // Prevent exiting the app.
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Double Tap to Exit App'),
        ),
        body: Center(
          child: Text(
            'Press system back button to exit.',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
