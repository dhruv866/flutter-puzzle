import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject{
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;

  User(this.id , this.name);
}