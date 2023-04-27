import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../db/functions/dbfunctions.dart';
import '../../model/cart mode.dart';

class ScreenHomeDelivery extends StatefulWidget {
  const ScreenHomeDelivery({super.key});

  @override
  State<ScreenHomeDelivery> createState() => _ScreenHomeDeliveryState();
}

class _ScreenHomeDeliveryState extends State<ScreenHomeDelivery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text("All Orders"),
          Container(
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
                        trailing: Text(''),
                      );
                    },
                  );
                },
              ))
        ],
      ),
    );
  }
}
