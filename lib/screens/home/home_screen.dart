import 'package:floor_db/db/entities/contacts.dart';
import 'package:floor_db/db/service/local_db_service.dart';
import 'package:floor_db/screens/home/widgets/contact_form_field.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Contacts> contacts = [];
  late ContactFormField form;

  @override
  void initState() {
    super.initState();
    fetchAllContacts();
  }

  fetchAllContacts() async {
    contacts = await (await LocalDbService.contactDao).getAll();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
        centerTitle: true,
      ),
      body: Column(children: [
        ContactFormField(
          onSave: fetchAllContacts,
          onReady: (form) {
            form;
          },
        ),
        Expanded(
            child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Colors.blue),
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Text(
                  contacts[index].name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  contacts[index].phone,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                trailing: GestureDetector(
                  onTap: () => onTabEdit(index),
                  child: Icon(
                    Icons.edit,
                    color: Colors.red,
                  ),
                ),
              ),
            );
          },
        )),
      ]),
    );
  }

  void onTabEdit(int index) {
    form.edit(contacts[index]);
  }
}
