import 'package:flutter/material.dart';

import '../../model/cart mode.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<AddtoCart>> cartListNotifier = ValueNotifier([]);

Future<void> addCartData(AddtoCart value) async {
  //
  final cartDataBase = await Hive.openBox<AddtoCart>('cart_db');
  final _id = await cartDataBase.add(value);
  value.id = _id;
  cartListNotifier.value.add(value);
  cartListNotifier.notifyListeners();
}

Future<void> getCartData() async {
  final cartDataBase = await Hive.openBox<AddtoCart>('cart_db');
  cartListNotifier.value.clear();
  cartListNotifier.value.addAll(cartDataBase.values);
  cartListNotifier.notifyListeners();
}

Future<void> deleteCart(int id) async {
  final cartDataBase = await Hive.openBox<AddtoCart>('cart_db');
  await cartDataBase.delete(id);
  getCartData();
}
