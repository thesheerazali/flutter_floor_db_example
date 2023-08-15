import 'package:floor/floor.dart';
import 'package:floor_db/db/entities/contacts.dart';

@dao
abstract class ContactDao {
  @Query("SELECT * FROM contacts")
  Future<List<Contacts>> getAll();

  @Query("SELECT * FROM contacts WHERE id= :id")
  Future<Contacts?> findbyid(int id);

  @Query("SELECT * FROM contacts WHERE name LIKE '%:name%'")
  Future<Contacts?> findbyname(String name);

  @Query("SELECT * FROM contacts WHERE phone LIKE '%:phone%'")
  Future<Contacts?> findbyphone(String phone);

  @insert
  Future<void> addContacts(Contacts contacts);
  @update
  Future<void> updateContacts(Contacts contacts);
  @delete
  Future<void> deleteContacts(Contacts contacts);
}
