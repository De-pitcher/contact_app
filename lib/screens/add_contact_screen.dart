import 'package:flutter/material.dart';
import 'package:contact_app/widgets/text_field.dart';

import '../models/group.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  late TextEditingController _firstNamecontroller;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  String? dropdownValue = groupString[Group.non];

  @override
  void initState() {
    _firstNamecontroller = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _firstNamecontroller.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Create new contact'),
        actions: const [Icon(Icons.check)],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.person),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Textfield(
                    hint: 'FirstName',
                    controller: _firstNamecontroller,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Textfield(
                hint: 'LastName',
                controller: _lastNameController,
              ),
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
                Expanded(
                  child: phoneTextField(
                    hint: 'Phone',
                    controller: _phoneController,
                  ),
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
                Expanded(
                  child: Textfield(
                    hint: 'Email',
                    controller: _emailController,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: DropdownButtonFormField(
                hint: const Text('select group'),
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
            ),
          ],
        ),
      ),
    );
  }
}
