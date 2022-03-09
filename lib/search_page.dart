import 'package:contact_search/contact.dart';
import 'package:flutter/material.dart';

final List<Contact> contacts = [
  Contact(fullName: 'Ganesh', number: '9876543210'),
  Contact(fullName: 'Dinesh', number: '8794563210'),
  Contact(fullName: 'Somesh', number: '6352419870'),
  Contact(fullName: 'Rakesh', number: '6352852470'),
  Contact(fullName: 'Mahesh', number: '6340259870'),
  Contact(fullName: 'Mukesh', number: '6352419963'),
  Contact(fullName: 'Suresh', number: '6352002170'),
  Contact(fullName: 'Kamal', number: '6352417954'),
  Contact(fullName: 'Sonu', number: '6352009870'),
  Contact(fullName: 'Raj Kumar', number: '6352410170'),
  Contact(fullName: 'Tarun', number: '6352201270'),
  Contact(fullName: 'Vinod', number: '6352419856'),
  Contact(fullName: 'Arun', number: '6352419000'),
  Contact(fullName: 'Lucky', number: '9632419870'),
  Contact(fullName: 'Ramesh', number: '7410541230')
];

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch(contacts));
            },
          ),
        ],
      ),
      body: ContactList(contacts: contacts),
    );
  }
}

class DataSearch extends SearchDelegate {
  final List<Contact> filteredContacts;

  DataSearch(this.filteredContacts);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation));
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggesstionList = filteredContacts
        .where((p) =>
            p.fullName.toLowerCase().contains(query.toLowerCase()) ||
            p.number.contains(query))
        .toList();
    return ContactList(contacts: suggesstionList);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggesstionList = filteredContacts
        .where((p) =>
            p.fullName.toLowerCase().contains(query.toLowerCase()) ||
            p.number.contains(query))
        .toList();
    return ContactList(contacts: suggesstionList);
  }
}

class ContactList extends StatelessWidget {
  final List<Contact> contacts;
  const ContactList({Key? key, required this.contacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          return Card(child: _ContactListItem(contacts[index]));
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
