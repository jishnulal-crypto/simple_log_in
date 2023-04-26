import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../db/functions/dbfunctions.dart';
import '../model/cart mode.dart';

class ScreenCart extends StatefulWidget {
  const ScreenCart({super.key});

  @override
  State<ScreenCart> createState() => _ScreenCartState();
}

class _ScreenCartState extends State<ScreenCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(physics: BouncingScrollPhysics(), children: [
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
                          trailing: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                        title: Text(
                                          "Delete ?",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18),
                                        ),
                                        // title: Text("Log out"),
                                        content: Text(
                                          "Are you sure",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              if (data.id != null) {
                                                deleteCart(data.id!);
                                              } else {
                                                print("Can't delete this");
                                              }
                                              Navigator.of(ctx).pop();
                                            },
                                            child: Text(
                                              "Delete",
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
                              // if (data.id != null) {
                              //   deleteCart(data.id!);
                              // } else {
                              //   print("Can't delete this");
                              // }
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          )),
                    );
                  },
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}
