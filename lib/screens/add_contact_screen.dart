import 'package:contact_app/models/group.dart';
import 'package:flutter/material.dart';

import '../widgets/contact_widget.dart';


class AddContact extends StatefulWidget {
  static const id = '/add-contact';

  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  @override
  Widget build(BuildContext context) {
    return const ContactWidget(group: Group.non);
  }
}
