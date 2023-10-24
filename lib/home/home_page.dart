import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twelve_x_bull/contant/upiconstant.dart';
import 'package:twelve_x_bull/home/betting_popup.dart';
import 'package:twelve_x_bull/home/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:twelve_x_bull/transaction/add_money.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Metals> metalslist = [];
  Future<List<Metals>> getMetals() async {
    print("ashutosh");
    final response = await http.get(Uri.parse("${AppUrl.baseurl}get_metel"));
    final data = jsonDecode(response.body)['data'];
    print(data);
    debugPrint('datadatadatadatadata');
    if (response.statusCode == 200) {
      metalslist.clear();
      for (var o in data) {
        Metals abcd = Metals(
          metel_type: o["metel_type"],
          meteltypehindi: o["meteltypehindi"],
          metal_icon: o["metal_icon"],
          id: o["id"],
          status:o["status"]
        );
        metalslist.add(abcd);
      }
      return metalslist;
    } else {
      return metalslist;
    }
  }

  void initState() {
    viewprofile();
    viewResult();
    super.initState();
  }

  var map;
  Future viewprofile() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getString("userId");
    final url = Uri.parse(
        "https://www.12xbulls.com/admin/api/Mobile_app/get?id=$userid"
    );
    print('object');
    print(url);
    print('object');
     final response = await http.get(url);
    var data = jsonDecode(response.body);
    print(data);
    print("mmmmmmmmmmmmmmm");
    if (data['success'] == '200') {
      setState(() {
        map = data['data'];
      });
    }
    final resp = await http.get(
      Uri.parse(AppUrl.baseurl + "wins"),
    );
    setState(() {
      var datad = jsonDecode(resp.body)['data'];
      ann = datad[0];
      print(ann);
    });
  }
  bool isResultView= false;
  Future viewResult() async {
    final url = Uri.parse(
        "https://12xbulls.com/admin/api/Mobile_app/lastresult"
    );
    final response = await http.get(url);

    var data = jsonDecode(response.body);
    print("result daa");
    print(data);
    if (data['error'] == '200') {
      setState(() {
        result= data['data'][0];
        isResultView=true;
        print(result);
      });
      Future.delayed(Duration(minutes: 15
      ), () {
        setState(() {
          isResultView=false;
        });
        print("delayed function invoked");
      });
    }
  }
var result;


  var ann;
  @override
  Widget build(BuildContext context) {//result== null || || metalslist == null
    return
      ann == null ?
        Scaffold(
          backgroundColor: const Color(0xff272139),
          body: Center(
            child: CircularProgressIndicator(),
          ),
        )
    :
    Scaffold(
      backgroundColor: const Color(0xff272139),
      appBar: AppBar(
        backgroundColor: const Color(0xff272139),
        centerTitle: true,
        // leading: Image.asset('assets/images/img.png'),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Add_Money()));
            },
            child: Container(
              // width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.account_balance_wallet_rounded),
                  SizedBox(width: 10,)
                  // map == null
                  //     ? const Text("₹")
                  //     : Text(
                  //         map['wallet'].toString(),
                  //         style: const TextStyle(color: Colors.white),
                  //       )
                ],
              ),
            ),
          )
        ],
        title: const Text(
          '12xBull',
          style: TextStyle(fontSize: 30),
        ),
        elevation: 0,
      ),
      drawer: const Drawer_Page(),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 1), () {
            setState(() {});
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Divider(
                  thickness: 1.5,
                  color: Colors.white,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    map == null
                        ? 'Name'
                        : 'Hello ' + map['name'].toString() + ',',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xffd2b086), Color(0xff594f43)]),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2, color: Colors.white),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image:isResultView==false? DecorationImage(//isResultView==true?NetworkImage("https://12xbulls.com/admin/uploads/"+result['image'])
                            // image: NetworkImage("https://12xbulls.com/admin/uploads/bul.jpg"),
                            image:AssetImage("assets/images/applogo.png"),
                            fit: BoxFit.cover
                          ):DecorationImage(//isResultView==true?NetworkImage("https://12xbulls.com/admin/uploads/"+result['image'])
                            // image: NetworkImage("https://12xbulls.com/admin/uploads/bul.jpg"),
                              image:NetworkImage("https://12xbulls.com/admin/uploads/"+result['image']),
                              fit: BoxFit.cover
                          )
                        ),
                        // child: Image.network(
                        //     "https://12xbulls.com/admin/uploads/bul.jpg"
                        //   // +ann!=null?'bul.jpg':ann['metel'].toString()
                        // ),
                      )
                      // CircleAvatar(
                      //   radius: 20,
                      //   backgroundImage: NetworkImage('https://12xbulls.com/admin/uploads/'+ann['metel']==null?'bul.jpg':ann['metel'].toString()),
                      // ),
                      ,
                      // Text(
                      //   ann == null
                      //       ? ''
                      //       : ann['metel_type'].toString() + 'is Winner',
                      //   style: const TextStyle(
                      //     color: Colors.white,
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 15,
                      //   ),
                      // ),
                      Text(isResultView==true?"${result["metal"]} is winner":"Waiting...",style: TextStyle(fontSize: 25, color:isResultView==true? Colors.red:Colors.black, fontWeight: FontWeight.w600),),
                      Image.asset('assets/images/winner.gif',)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 1.5,
                  color: Colors.white,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.62,
                  child: FutureBuilder<List<Metals>>(
                      future: getMetals(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);
                        if (snapshot.hasData) {
                          print(snapshot.data);
                          print('snapshot.data');
                          return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            betting_Popup(snapshot.data![index]),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      height: 70,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        // gradient: LinearGradient(
                                        //     begin: Alignment.topLeft,
                                        //     end: Alignment.bottomRight,
                                        //     stops: [0.1, 0.3, 0.7, 1],
                                        //     colors: [Color(0xff5a268a), Color(0xff765e8d), Color(0xffd7c3eb), Color(0xff421d64)]),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            width: 2, color: Colors.white),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 55,
                                            width: 55,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    "https://12xbulls.com/admin/uploads/" +
                                                        snapshot.data![index]
                                                            .metal_icon
                                                            .toString()),
                                              ),
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                const BoxShadow(
                                                    blurRadius: 3,
                                                    color: Colors.black,
                                                    spreadRadius: 1)
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width/3.5,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  snapshot.data![index].metel_type
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                Text(
                                                  snapshot
                                                      .data![index].meteltypehindi
                                                      .toString(),
                                                  style: const TextStyle(
                                                    color: Colors.black45,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                         snapshot.data![index].status.toString()=="0"? Container(
                                              height: 60,
                                              width: 60,
                                              child: Image.asset(
                                                  'assets/images/graph.png')):
                                         Container(
                                             height: 60,
                                             width: 60,
                                             child: Image.asset(
                                                 'assets/images/growthgreen.png')),
                                          const Text(
                                            '44100',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Metals {
  String? metel_type;
  String? meteltypehindi;
  String? metal_icon;
  String? id;
  String? status;

  Metals({this.metel_type, this.meteltypehindi, this.metal_icon, this.id, this.status});
}
