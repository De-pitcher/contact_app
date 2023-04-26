import 'package:flutter/material.dart';
import 'package:contact_app/widgets/text_field.dart';

import '../models/group.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final TextEditingController _controller = TextEditingController();
  String? dropdownValue = groupString[Group.non];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text('Create new contact'),
        actions: const [Icon(Icons.check)],
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.person),
                const SizedBox(
                  width: 5,
                ),
                Textfield(
                  hint: 'FirstName',
                  controller: _controller,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Textfield(
              hint: 'LastName',
              controller: _controller,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Icon(Icons.phone),
                const SizedBox(
                  width: 5,
                ),
                Textfield(
                  hint: 'Phone',
                  controller: _controller,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Icon(Icons.mail),
                const SizedBox(
                  width: 5,
                ),
                Textfield(
                  hint: 'Email',
                  controller: _controller,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            DropdownButtonFormField(
              value: dropdownValue,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: groupString.values
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
