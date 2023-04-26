import 'package:hive/hive.dart';
part 'cart mode.g.dart';

@HiveType(typeId: 1)
class AddtoCart {
  @HiveField(0)
  int? id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String email;

  @HiveField(3)
  late String phoneNumber;

  @HiveField(4)
  late String lat;

  @HiveField(4)
  late String long;

  @HiveField(6)
  late String location;

  AddtoCart(
      {required this.name,
      required this.email,
      required this.phoneNumber,
      required this.lat,
      required this.long,
      required this.location,
      this.id});
}
