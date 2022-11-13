import 'package:isar/isar.dart';
import 'package:pocketbase/pocketbase.dart';

part 'session.g.dart';

@collection
class Session {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment
  String? token;
  @ignore
  UserAuth? user;
}
