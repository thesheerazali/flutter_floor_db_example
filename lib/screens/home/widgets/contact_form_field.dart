// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:floor_db/db/entities/contacts.dart';
import 'package:floor_db/db/service/local_db_service.dart';

class ContactFormField extends StatefulWidget {
  Function onSave;
  ValueChanged<ContactFormField> onReady;
  int? editid;

  TextEditingController nameCont = TextEditingController();

  TextEditingController phoneCont = TextEditingController();

  edit(Contacts contacts) {
    nameCont.text = contacts.name;
    phoneCont.text = contacts.phone;
    editid = contacts.id; 
  }

  ContactFormField({Key? key, required this.onSave, required this.onReady})
      : super(key: key);

  @override
  State<ContactFormField> createState() => _ContactFormFieldState();
}

class _ContactFormFieldState extends State<ContactFormField> {
  @override
  Widget build(BuildContext context) {
    widget.onReady(widget);
    return Form(
      child: Builder(
        builder: (childContext) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            TextFormField(
              controller: widget.nameCont,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Enter Name",
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? "Please Enter Name" : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: widget.phoneCont,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Enter Phone Num",
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? "Please Enter Phone" : null,
              keyboardType: TextInputType.phone,
            ),
            ElevatedButton(
                onPressed: () => saveContact(childContext),
                child: const Text("Save"))
          ]),
        ),
      ),
    );
  }

  saveContact(BuildContext childContext) async {
    if (Form.of(childContext).validate()) {}

    if (widget.editid == null) {
      (await LocalDbService.contactDao).addContacts(
          Contacts(null, widget.nameCont.text, widget.phoneCont.text));
    } else {
      (await LocalDbService.contactDao).updateContacts(
          Contacts(widget.editid, widget.nameCont.text, widget.phoneCont.text));
    }
    widget.nameCont.clear();
    setState(() {
      widget.editid = null;
    });
    widget.phoneCont.clear();
    widget.onSave();
  }
}
