import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login Page.dart';

class ScreenDashboard extends StatefulWidget {
  final String? name;
  ScreenDashboard({super.key, required this.name});

  @override
  State<ScreenDashboard> createState() => _ScreenDashboardState();
}

class _ScreenDashboardState extends State<ScreenDashboard> {
  late String? email;
  late String? password;
  late String? username;

  Future checkData() async {
    final sharedPref = await SharedPreferences.getInstance();
    email = sharedPref.getString('useremail');
    password = sharedPref.getString('userpassword');
    username = sharedPref.getString('username');
  }

  // String? username;

  @override
  void initState() {
    checkData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(60)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Welcome \n${widget.name}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                                title: Text(
                                  "Log out",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                // title: Text("Log out"),
                                content: Text(
                                  "Log out of your account",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      SignOut(ctx);
                                    },
                                    child: Text(
                                      "Log out",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Text(
                                      "No",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                  ),
                                ],
                              ));
                    },
                    child: Text("Log out"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future SignOut(BuildContext ctx) async {
    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => ScreenLogin()), (route) => false);
    final sharedpref = await SharedPreferences.getInstance();
    await sharedpref.clear();
  }
}
