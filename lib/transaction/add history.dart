import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twelve_x_bull/contant/upiconstant.dart';

class AddHistory extends StatefulWidget {
  const AddHistory({Key? key}) : super(key: key);

  @override
  State<AddHistory> createState() => _AddHistoryState();
}

class _AddHistoryState extends State<AddHistory> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff272139),

      // TransactionBar: TransactionBar(),
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
                  return   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        margin: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        height: 80,
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

                                Text(
                                  snapshot.data![index].date
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.black),
                                ),
                                Text(
                                  snapshot.data![index].time
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            Text(
                              snapshot.data![index].status == '0' ?
                              'pending':snapshot.data![index].status == '1' ?'success':'rejected',
                              style: TextStyle(
                                  color: snapshot.data![index].status == '1' ? Colors.green: snapshot.data![index].status == '0'?Colors.orangeAccent:Colors.red,
                                  fontWeight: FontWeight.w900
                              ),
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
      Uri.parse(AppUrl.baseurl+"payinuserlist?user_id=$userid"),
    );
    var jsond = json.decode(response.body)["data"];
    print(jsond);
    List<Album> allround = [];
    for (var o in jsond)  {
      Album al = Album(
        o["amount"],
        o["date"],
        o["time"],
        o["status"],
      );

      allround.add(al);
    }
    return allround;
  }
}

class Album {
  String amount;
  String date;
  String time;
  String status;


  Album(this.amount,
      this.date,
      this.time,
      this.status,

      );

}

