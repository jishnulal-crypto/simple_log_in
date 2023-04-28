import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_login/Screens/Delivery%20boy%20Screens/Delivery%20boy%20Home%20screen.dart';

import 'package:simple_login/Screens/Register%20page.dart';

import 'Dashboard google.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late String? email;
  late String? password;
  late String? name;

  final user = "user";
  final delivery = "delivery";
  final passwordlogin = "qwerty";

  String? newuser;

  Future checkData() async {
    final sharedPref = await SharedPreferences.getInstance();
    email = sharedPref.getString('useremail');
    password = sharedPref.getString('userpassword');
    name = sharedPref.getString('username');
  }

  Future<void> signInwithGoogle() async {
    // create instance
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    // Triger the aauthentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    // obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    // create a new credentials
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    // sign in the user with credentials
    final UserCredential userCredential =
        await auth.signInWithCredential(credential);
  }

  @override
  void initState() {
    checkData();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 2 - 50),
              child: FlutterLogo(
                size: 100,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("User name"),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                validator: (value) {
                  // if (value != email) {
                  if (value == null || value.isEmpty) {
                    return "Please check your username";
                  } else {
                    return null;
                  }
                },
                controller: usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("Password"),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                validator: (value) {
                  if (value != passwordlogin) {
                    // if (value != password) {
                    return "password is invalid";
                  }
                },
                controller: passWordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ScreenRegister(),
                        ),
                      );
                    },
                    child: Text("Register")),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (usernameController.text == user) {
                          print("hai");
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => ScreenGoogleDashboard(),
                            ),
                          );
                        } else if (usernameController.text == delivery) {
                          print("hello");
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => ScreenHomeDelivery(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("user not found")));
                        }
                      } else {
                        print("error");
                      }
                    },
                    child: Text("Log in")),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 2 - 10),
              child: Text(
                "Or",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            //   Padding(
            //     padding: EdgeInsets.symmetric(
            //         horizontal: MediaQuery.of(context).size.width / 2 - 125),
            //     child: GestureDetector(
            //       onTap: () async {
            //         await signInwithGoogle();

            //         if (mounted) {
            //           Navigator.of(context).pushReplacement(MaterialPageRoute(
            //             builder: (context) => ScreenGoogleDashboard(),
            //           ));
            //         }
            //       },
            //       child: Container(
            //         height: 60,
            //         width: 250,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(15),
            //           color: Colors.green,
            //         ),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Image.asset(
            //               "assets/icons/google.png",
            //               fit: BoxFit.cover,
            //             ),
            //             Text(
            //               "Sign in with google",
            //               style: TextStyle(
            //                   fontSize: 16,
            //                   fontWeight: FontWeight.w400,
            //                   color: Colors.white),
            //             ),
            //             SizedBox(
            //               width: 2,
            //             )
            //           ],
            //         ),
            //       ),
            //     ),
            //   )
          ],
        ),
      )),
    );
  }
}
