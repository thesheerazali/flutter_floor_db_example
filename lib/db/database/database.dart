// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:floor_db/db/dao/contact_dao.dart';
import 'package:floor_db/db/entities/contacts.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Contacts])
abstract class AppDatabase extends FloorDatabase {
  static const String dbName = "contact_db.db";
  ContactDao get contactDao;
}
