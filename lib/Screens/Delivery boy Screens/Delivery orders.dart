import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../db/functions/dbfunctions.dart';
import '../../model/cart mode.dart';

class ScreenDeleveryOrders extends StatefulWidget {
  const ScreenDeleveryOrders({super.key});

  @override
  State<ScreenDeleveryOrders> createState() => _ScreenDeleveryOrdersState();
}

class _ScreenDeleveryOrdersState extends State<ScreenDeleveryOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text("All Orders"),
          SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ValueListenableBuilder<List<AddtoCart>>(
                valueListenable: cartListNotifier,
                builder: (context, cartList, child) {
                  return ListView.builder(
                    itemCount: cartList.length,
                    itemBuilder: (context, index) {
                      final data = cartList[index];
                      return ListTile(
                        title: Text(data.name),
                        subtitle: Text(data.location),
                        trailing: IconButton(
                            onPressed: () async {
                              launchMapsUrl();
                              // await _openMap(data.lat, data.long);
                              openMap(data.lat, data.long);
                            },
                            icon: Icon(
                              Icons.near_me,
                              color: Colors.green[300],
                            )),
                      );
                    },
                  );
                },
              ))
        ],
      ),
    );
  }

  void launchMapsUrl() async {
    final url = 'https://www.google.com/maps/search/?api=1&query=Google';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _openMap(String lat, String long) async {
    String googleUrl =
        "https://www.google.com/maps/search/?api=1&query=$lat,$long";
    await canLaunchUrlString(googleUrl)
        ? await launchUrlString(googleUrl)
        : throw "could not launch $googleUrl";
  }

  Future<void> openMap(String latitude, String longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=${double.parse(latitude)},${double.parse(longitude)}';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
