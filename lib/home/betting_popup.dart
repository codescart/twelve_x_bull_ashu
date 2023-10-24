import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twelve_x_bull/bottom_navbar.dart';
import 'package:twelve_x_bull/contant/upiconstant.dart';
import 'package:twelve_x_bull/home/home_page.dart';
import 'package:twelve_x_bull/transaction/addmoney_page.dart';
import 'package:twelve_x_bull/transaction/transaction_page.dart';

class betting_Popup extends StatefulWidget {
final Metals suraj;
betting_Popup(this.suraj);

  @override
  State<betting_Popup> createState() => _betting_PopupState();
}

class _betting_PopupState extends State<betting_Popup> {
  var output = 0;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Color(0xff272139),
      child: _buildChild(context),
    );
  }

  TextEditingController amount = TextEditingController();
  bool _loading = false;
  final _globalkey = GlobalKey<FormState>();

  _buildChild(BuildContext context) =>Container(
    child:
    Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Positioned(
          right: -15.0,
          top: -15.0,
          child: InkResponse(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: CircleAvatar(
              child: Icon(Icons.close),
              backgroundColor: Colors.red,
            ),
          ),
        ),
        Container(
          height: 350,
          child: Center(
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceEvenly,
              children: [
                Text(widget.suraj.metel_type!,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25),
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      "https://12xbulls.com/admin/uploads/" +
                          widget.suraj.metal_icon!),
                ),
                Text(
                  'Enter Amount',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25),
                ),
                Form(
                  key: _globalkey,
                  child: TextFormField(
                    controller: amount,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Amount';
                      }else if (int.parse(value)<=9) {
                        return 'Please enter minimum 10 rs amount';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      final data = int.parse(value);
                      final result = data * 10;
                      setState(() {
                        output = result;
                      });
                    },

                    maxLength: 7,
                    style: TextStyle(color: Colors.white, fontSize: 40),
                    cursorColor: Colors.white,
                    textAlign: TextAlign.center,
                    // cursorHeight: 40,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      counterText: "",
                      hintText: '00',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Text(
                  '*You will win 10x  = ' + output.toString(),
                  style: TextStyle(color: Colors.grey),
                ),
                Container(
                  height: 50,
                  width: 200,
                  decoration:
                  BoxDecoration(
                    // gradient: LinearGradient(colors: [Color(0xffd2b086), Color(0xff594f43)]),
                    color: Colors.green,
                    borderRadius:
                    BorderRadius
                        .circular(10),
                    border: Border.all(
                        width: 2,
                        color:
                        Colors.white),
                  ),
                  child: OutlinedButton(
                      onPressed: () {
                        if (_globalkey.currentState!.validate()) {
                          _beting(amount.text);
                        }

                      },
                      child: Text('Pay',
                          style: TextStyle(
                              fontSize:
                              25,
                              color: Colors
                                  .white))),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );

  _beting(String amount,) async {
    // setState(() {
    //   _loading == true;
    // });
    var id =widget.suraj.id;
    final prefs = await SharedPreferences.getInstance();
    final userid=prefs.getString("userId");
    print(userid);
    print("qqqqqqqqqqqqqqq");

    final response = await http.post(
      Uri.parse(
          AppUrl.baseurl+"betadd"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "amount": amount,
        "userid": "$userid",
        "gameid": id!,
      }),
    );

    var data = jsonDecode(response.body);
    print('pppppppp');
    print(data);
    if (data["success"] == "200") {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Transaction()));
      Fluttertoast.showToast(
          msg:data["msg"] ,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          backgroundColor: Colors.green,
          fontSize: 16.0);

    } else {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddMoneyUpi()));
      Fluttertoast.showToast(
          msg:data["msg"] ,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          backgroundColor: Colors.red,
          fontSize: 16.0);
      print("Error");
    }
  }

}
