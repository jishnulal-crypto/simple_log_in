import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:simple_login/Screens/cart.dart';
import 'package:simple_login/db/functions/dbfunctions.dart';
import 'package:simple_login/model/cart%20mode.dart';

class ScreenPurcahase extends StatefulWidget {
  const ScreenPurcahase({super.key});

  @override
  State<ScreenPurcahase> createState() => _ScreenPurcahaseState();
}

class _ScreenPurcahaseState extends State<ScreenPurcahase> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  late String _lat;
  late String _long;

  String currentLocation = "Current location";
  late String lanAndLong;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("Name"),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Please check your name";
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(content: Text("Enter your name")));
                  }
                },
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("Email"),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Please check your email";
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(content: Text("Enter your email")));
                  }
                },
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("Phone Number"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty || value.length != 10) {
                    return "Please check your number";
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(content: Text("Please check your number")));
                  }
                },
                maxLength: 10,
                keyboardType: TextInputType.number,
                controller: phoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("Location"),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(currentLocation),
            ),
            const SizedBox(
              height: 10,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: ElevatedButton(
            //       onPressed: () async {

            //       },
            //       child: const Text("Add current Location")),
            // ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() || _lat.isNotEmpty) {
                      placeOrderbutton(context);
                    } else {
                      print("hai");
                      showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                                title: Text(
                                  "Error",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                // title: Text("Log out"),
                                content: Text(
                                  "please give your location",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Text(
                                      "Ok",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                  ),
                                ],
                              ));

                      // ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(content: Text("Add your location")));
                    }

                    // Navigator.of(context)
                    //     .pushReplacement(MaterialPageRoute(builder: (context) {
                    //   return ScreenCart();
                    // }));
                  },
                  child: const Text("Place Order")),
            )
          ],
        ),
      )),
    );
  }

  Future placeOrderbutton(BuildContext context) async {
    await _getCurrentLocation().then((value) {
      _lat = '${value.latitude}';
      _long = '${value.longitude}';
    });
    final cityName = await getCityName(
        double.parse(_lat), double.parse(_long)); // San Francisco

    // lanAndLong = 'Latitude: $lat , Longitude: $long';
    setState(() {
      currentLocation = cityName;
    });
    final _name = nameController.text;
    final _email = emailController.text;
    final _phonenumber = phoneController.text.trim.toString();
    final _cartData = AddtoCart(
        name: _name,
        email: _email,
        phoneNumber: _phonenumber,
        lat: _lat,
        long: _long,
        location: currentLocation);
    addCartData(await _cartData);
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ScreenCart();
    }));
  }

  Future _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled.");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions are denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location Permission are permenently denied, we cannot request");
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<String> getCityName(double lat, double lng) async {
    final url =
        'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$lat&lon=$lng';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final address = decoded['address'];

      if (address != null) {
        if (address['city'] != null) {
          return address['city'];
        } else if (address['town'] != null) {
          return address['town'];
        } else if (address['village'] != null) {
          return address['village'];
        } else if (address['county'] != null) {
          return address['county'];
        }
      }
    }

    throw Exception("error found");
  }
}
