import 'package:hive/hive.dart';
part 'wishlist.g.dart';

@HiveType(typeId: 0)
class WishList {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String imageUrl;

  WishList({
    required this.id,
    required this.title,
    required this.imageUrl,
  });
}
