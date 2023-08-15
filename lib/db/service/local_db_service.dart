import 'package:floor_db/db/dao/contact_dao.dart';
import 'package:floor_db/db/database/database.dart';

abstract class LocalDbService {
  static Future<AppDatabase> get _db async =>
      await $FloorAppDatabase.databaseBuilder(AppDatabase.dbName).build();

 static Future<ContactDao> get contactDao async => (await _db).contactDao;


}
