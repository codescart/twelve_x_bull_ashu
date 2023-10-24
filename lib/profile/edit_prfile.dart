import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twelve_x_bull/constant_textformfild.dart';
import 'package:twelve_x_bull/contant/upiconstant.dart';
import 'package:twelve_x_bull/notification.dart';
import 'package:twelve_x_bull/profile/profile_page.dart';

class EditProfile extends StatefulWidget {

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  void initState() {
    genderrr();

    super.initState();
  }

  String? dropdownvalue;
  List gender_data = [];
  Future<String> genderrr() async {
    final res = await http.get(Uri.parse(
        AppUrl.baseurl+"getgender"));
    final resBody = json.decode(res.body);
    setState(() {
      gender_data = resBody['data'];
    });
    return "Sucess";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff272139),
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            '12xBull',
            style: TextStyle(fontSize: 30),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff272139),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Notification_Page()));
                },
                icon: Icon(Icons.notifications_none))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Column(children: [
              Container(
                height: 100,
                width: 100,
                // color: Colors.red,
                child: Image.asset('assets/images/img.png'),
              ),

              EntryField(
                textInputType: TextInputType.name,
                label: "Name",
                hint: "Enter Name",
                controller: name,
              ),

              EntryField(
                textInputType: TextInputType.name,
                label: "Mobile Number",
                hint: "Enter Mobile no",
                controller: phone,
              ),
              // EntryField(
              //   label: "Phone",
              //   hint: "Enter Phone",
              //   controller: _phone,
              // ),
              EntryField(
                textInputType: TextInputType.number,
                label: "Age",
                hint: "Enter Age",
                controller: age,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 10, bottom: 10, right: 280),
              //   child: Text('Gender',
              //     style: TextStyle(fontSize: 15, color: Colors.white),
              //   ),
              // ),
              // Container(
              //   height: 50,
              //   width: MediaQuery.of(context).size.width*0.94,
              //   padding: EdgeInsets.only(left: 10, right: 10),
              //   decoration: BoxDecoration(
              //     border: Border.all(width: 1, color: Colors.white),
              //     borderRadius: BorderRadius.circular(20.0),
              //   ),
              //   child: DropdownButtonHideUnderline(
              //     child:DropdownButton(
              //       dropdownColor: Colors.grey,
              //       value: dropdownvalue,
              //       hint:  Text('Choose Gender',
              //         style: TextStyle(
              //           fontSize: 17,
              //           color:Colors.white,
              //         ),
              //       ),
              //       items: gender_data.map((item) {
              //         return DropdownMenuItem(
              //             child:  Text(
              //               item['gender'].toString(),
              //               style: TextStyle(
              //                 fontSize: 17,
              //                 color: Colors.white
              //               ),
              //             ),
              //             value: item['id'].toString()
              //         );
              //       }).toList(),
              //       onChanged: (value) async {
              //         setState(() {
              //           dropdownvalue = value;
              //         }
              //         );
              //       },
              //     ),
              //   ),
              // ),
              EntryField(
                textInputType: TextInputType.emailAddress,
                label: "Email",
                hint: "Enter Email",
                controller: email,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(onPressed: () {
                    editprofile(name.text,phone.text,age.text,email.text);
                  }, child: Text('Submit')),
                ),
              )
            ]),
          ),
        ));
  }

 editprofile(
     String name,
     String phone,
     String age,
     String email,
     ) async{
   final prefs = await SharedPreferences.getInstance();
   final userid=prefs.getString("userId");

    var response = await http.post(
      Uri.parse(AppUrl.baseurl+"profile_put"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "userid":'$userid',
        "name":name,
        "phone":phone,
        "age":age,
        "email":email,
      }),
    );

    var data = jsonDecode(response.body);
    print('pppppp');
    print(data);
    if(data["error"]=="200"){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Profile()));
    }else{
      print("Error");
    }

 }
}
