import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final user = FirebaseAuth.instance.currentUser!;

  @override
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
                  "Welcome \n" + user.displayName!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(user.photoURL!),
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
                                    onPressed: () async {
                                      await SignOut(ctx);
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
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await sharedpref.clear();
  }
}
