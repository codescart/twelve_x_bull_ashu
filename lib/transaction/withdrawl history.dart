import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twelve_x_bull/contant/upiconstant.dart';

class WithdrawlHistory extends StatefulWidget {
  const WithdrawlHistory({Key? key}) : super(key: key);

  @override
  State<WithdrawlHistory> createState() => _WithdrawlHistoryState();
}

class _WithdrawlHistoryState extends State<WithdrawlHistory> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff272139),

      // WithdrawactionBar: WithdrawactionBar(),
      body: FutureBuilder<List<Album>>(
          future: bow(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  print(snapshot.data!.length);
                  return  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        margin: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        height: 90,
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            Text("₹ "+
                                snapshot.data![index].amount.toString(),
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            snapshot.data![index].account_number==''?
                                Text(
                                  "UPI " +
                                      snapshot.data![index].upi
                                          .toString(),
                                  style: TextStyle(
                                      color: Colors.black),
                                ):
                                Text(
                                  "A/c - " +
                                    snapshot.data![index].account_number
                                        .toString(),
                                  style: TextStyle(
                                      color: Colors.black),
                                ),
                                Text(snapshot.data![index].ifsc_code==''?"":
                                  "IFSC - " +
                                    snapshot.data![index].ifsc_code
                                        .toString(),
                                  style: TextStyle(
                                      color: Colors.black),
                                ),
                                Text("Date " +
                                    snapshot.data![index].date
                                        .toString(),
                                  style: TextStyle(
                                      color: Colors.black),
                                ),
                                Text(snapshot.data![index].name==''?'':
                                  "Name " +
                                    snapshot.data![index].name
                                        .toString(),
                                  style: TextStyle(
                                      color: Colors.black),
                                ),
                                Text(snapshot.data![index].phone==''?'':
                                "Phone " +
                                    snapshot.data![index].phone
                                        .toString(),
                                  style: TextStyle(
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(snapshot.data![index].description.toString(),style: TextStyle(
                                    fontWeight: FontWeight.w900,fontSize: 25)),
                                Text(
                                  snapshot.data![index].status == '0' ?
                                  'pending':snapshot.data![index].status == '1' ?'success':'rejected',
                                  style: TextStyle(
                                    color: snapshot.data![index].status == '1' ? Colors.green: snapshot.data![index].status == '0'?Colors.orangeAccent:Colors.red,
                                    fontWeight: FontWeight.w900
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  );

                }
            ):Center(child:LinearProgressIndicator(),);
          }
      )
    );
  }



   Future<List<Album>> bow() async{
     final prefs = await SharedPreferences.getInstance();
     final userid=prefs.getString("userId");
   final response = await http.get(
   Uri.parse(AppUrl.baseurl+"getwithdrawl?user_id=$userid"),

   );
   var jsond = json.decode(response.body)["data"];
   print(jsond);
   List<Album> allround = [];
   for (var o in jsond)  {
   Album al = Album(
   o["amount"],
   o["account_number"],
   o["ifsc_code"],
   o["upi"],
   o["date"],
   o["name"],
   o["status"],
   o["phone"],
   o["description"],

   );

   allround.add(al);
   }
   return allround;
   }
}
class Album {
  String amount;
  String account_number;
  String ifsc_code;
  String upi;
  String date;
  String name;
  String status;
  String phone;
  String? description;





  Album(this.amount,
      this.account_number,
      this.ifsc_code,
      this.upi,
      this.date,
      this.name,
      this.status,
      this.phone,
      this.description,
      );

}

