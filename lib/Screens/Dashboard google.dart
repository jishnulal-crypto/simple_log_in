import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_login/Screens/Purcahse.dart';
import 'package:simple_login/Screens/cart.dart';

import '../db/functions/dbfunctions.dart';
import 'Login Page.dart';

class ScreenGoogleDashboard extends StatefulWidget {
  ScreenGoogleDashboard({
    super.key,
  });

  @override
  State<ScreenGoogleDashboard> createState() => _ScreenGoogleDashboardState();
}

class _ScreenGoogleDashboardState extends State<ScreenGoogleDashboard> {
  // String? username;
  // final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    getCartData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ScreenCart();
                }));
              },
              icon: Icon(Icons.shopping_cart)),
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
        ],
      ),
      body: SafeArea(
          child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Text("Welcome"),
          Text("Items"),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    // childAspectRatio: 1,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    crossAxisCount: 2,
                    mainAxisExtent: 200),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ScreenPurcahase(),
                          ),
                        );
                      },
                      child: Container(
                        child: Center(child: Text("Product ${index + 1}")),
                        decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  );
                }),
          )
        ],
      )),
    );
  }

  Future SignOut(BuildContext ctx) async {
    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => ScreenLogin()), (route) => false);
    final sharedpref = await SharedPreferences.getInstance();
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await sharedpref.clear();
  }
}
