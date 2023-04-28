import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:simple_login/Screens/Login%20Page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../db/functions/dbfunctions.dart';
import '../../model/cart mode.dart';
import 'Delivery orders.dart';

class ScreenHomeDelivery extends StatefulWidget {
  const ScreenHomeDelivery({super.key});

  @override
  State<ScreenHomeDelivery> createState() => _ScreenHomeDeliveryState();
}

class _ScreenHomeDeliveryState extends State<ScreenHomeDelivery> {
  @override
  void initState() {
    getCartData();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text(
                            "Log out",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          // title: Text("Log out"),
                          content: Text(
                            "Log out of your account",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (ctx) => ScreenLogin()),
                                    (route) => false);
                              },
                              // async {
                              //   await SignOut(ctx);
                              // },
                              child: Text(
                                "Log out",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 14),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: Text(
                                "No",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 14),
                              ),
                            ),
                          ],
                        ));
              },
              icon: Icon(Icons.logout))
        ]),
        body: Column(
          children: [
            Text(DateTime.now().toString()),
            Container(
              child: Center(
                  child: ElevatedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ScreenDeleveryOrders())),
                child: Text("Orders"),
              )),
            )
          ],
        ));
  }
}
