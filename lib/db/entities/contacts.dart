import 'package:floor/floor.dart';

@entity
class Contacts {

  @PrimaryKey(autoGenerate: true)
  final int? id;

  
  final String name;
  final String phone;

  Contacts(this.id, this.name, this.phone);
}
