import 'package:contact_search/contact.dart';
import 'package:contact_search/search_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchPage(),
    ));

class ContactsPage extends StatefulWidget {
  Widget appBarTitle = const Text("Contacts");
  Icon actionIcon = const Icon(Icons.search);
  final List<Contact> contacts = [
    Contact(fullName: 'ganesh', number: '9876543210'),
    Contact(fullName: 'dinesh', number: '8794563210'),
    Contact(fullName: 'somesh', number: '6352419870'),
    Contact(fullName: 'ramesh', number: '7896541230')
  ];

  ContactsPage({Key? key}) : super(key: key);

  @override
  _ContactPage createState() => _ContactPage(contacts);
}

class _ContactPage extends State<ContactsPage> {
  List<Contact> filteredContacts;

  _ContactPage(this.filteredContacts);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: widget.appBarTitle,
          actions: <Widget>[
            IconButton(
              icon: widget.actionIcon,
              onPressed: () {
                setState(() {
                  if (widget.actionIcon.icon == Icons.search) {
                    widget.actionIcon = const Icon(Icons.close);
                    widget.appBarTitle = TextField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.white),
                          hintText: "Search...",
                          hintStyle: TextStyle(color: Colors.white)),
                      onChanged: (value) {
                        filterContacts(value);
                      },
                    );
                  } else {
                    widget.actionIcon = const Icon(Icons.search);
                    widget.appBarTitle = const Text("Contacts");
                    filteredContacts = widget.contacts;
                  }
                });
              },
            ),
          ],
        ),
        body: ContactList(contacts: filteredContacts),
      ),
    );
  }

  void filterContacts(String value) {
    var temp = widget.contacts.where((contact) {
      if (contact.number.contains(value)) {
        return contact.number.contains(value);
      }
      return contact.fullName.contains(value);
    }).toList();
    setState(() {
      filteredContacts = temp;
    });
  }
}

class ContactList extends StatelessWidget {
  final List<Contact> contacts;
  const ContactList({Key? key, required this.contacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          return _ContactListItem(contacts[index]);
        },
        itemCount: contacts.length,
        padding: const EdgeInsets.symmetric(vertical: 8.0));
  }
}

class _ContactListItem extends ListTile {
  _ContactListItem(Contact contact)
      : super(
            title: Text(contact.fullName),
            subtitle: Text(contact.number),
            leading: CircleAvatar(child: Text(contact.fullName[0])));
}
