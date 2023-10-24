import 'package:flutter/material.dart';
import 'package:twelve_x_bull/bottom_navbar.dart';
import 'package:twelve_x_bull/notification.dart';
import 'package:twelve_x_bull/transaction/add%20history.dart';
import 'package:twelve_x_bull/transaction/beting%20history.dart';
import 'package:twelve_x_bull/transaction/withdrawl%20history.dart';

class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      backgroundColor: Color(0xff272139),

      appBar: AppBar(
        elevation: 0,
        title: Text(
          '12xBull',
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff272139),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BottomNavBar()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => Notification_Page()));
        //       },
        //       icon: Icon(Icons.notifications_none))
        // ],
        bottom: TabBar(

          labelStyle: TextStyle(
            fontSize: 20.0,
          ), //For Selected tab
          unselectedLabelStyle: TextStyle(
            fontSize: 20.0,
          ),
          indicatorColor: Colors.white,
          controller: tabController,
          isScrollable: true,
          tabs: [
            Tab(
              child: Text(
                "Betting",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                "Add",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                "Withdraw",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      // TransactionBar: TransactionBar(),
      body: Column(
        children: [
          Expanded(
              child: TabBarView(
            controller: tabController,
            children: [
              BetingHistory(),
              AddHistory(),
              WithdrawlHistory(),
            ],
          ))
        ],
      ),
    );
  }
}
