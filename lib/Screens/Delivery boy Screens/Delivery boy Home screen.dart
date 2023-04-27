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
            child: ValueListenableBuilder(
              valueListenable: cartListNotifier,
              builder:
                  (BuildContext ctx, List<AddtoCart> cartList, Widget? child) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cartList.length,
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemBuilder: (context, index) {
                    final data = cartList[index];
                    return Card(
                        child: ListTile(
                      title: Text(data.name),
                      leading: Icon(Icons.shopping_cart),
                      subtitle: Text(data.location),
                    ));
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
