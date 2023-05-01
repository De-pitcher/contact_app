import 'package:flutter/material.dart';
import 'package:contact_app/widgets/text_field.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import '../data/hive_db.dart';
import '../models/group.dart';
import '../utils/app_color.dart';

class AddContact extends StatefulWidget {
  static const id = '/add-contact';

  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _firstName = '';
  var _lastName = '';
  var _number = '';
  var _email = '';
  var _isLoading = false;

  Group? dropdownValue = Group.non;


  void _setDropdownValue(Group value) {
    setState(() {
      dropdownValue = value;
    });
  }

  void _onCreate() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await HiveDb(Hive)
          .createContact(
            '$_firstName $_lastName',
            _number,
            _email,
            dropdownValue!,
          )
          .then((value) => Navigator.of(context).pop());
      setState(() {
        _isLoading = false;
      });
    }
  }

  String? _errorText(String text, [bool? isPhone]) {
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    if (isPhone != null && isPhone) {
      if (int.tryParse(text) == null) {
        return 'Not a valid number';
      }
      if (text.length < 11) {
        return 'Too short';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 10,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Create new contact'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton(
              onPressed: _onCreate,
              style: TextButton.styleFrom(foregroundColor: AppColor.primary),
              child: _isLoading
                  ? CircularProgressIndicator(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    )
                  : const Text('Save'),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 50),
              Textfield(
                hint: 'FirstName',
                icon: Icons.person,
                keyboardType: TextInputType.name,
                validator: (val) => _errorText(val!),    onChanged: (value) {
                  setState(() {
                    _firstName = value;
                  });
                },
              ),
              const SizedBox(
                height: 24,
              ),
              Textfield(
                hint: 'LastName',
                validator: (val) => _errorText(val!),    onChanged: (value) {
                  setState(() {
                    _lastName = value;
                  });
                },
              ),
              const SizedBox(
                height: 24,
              ),
              Textfield(
                hint: 'Phone',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (val) => _errorText(val!),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],    onChanged: (value) {
                  setState(() {
                    _number = value;
                  });
                },
              ),
              const SizedBox(
                height: 24,
              ),
              Textfield(
                hint: 'Email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (val) => _errorText(val!),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              const SizedBox(
                height: 48,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Select group'),
                  const SizedBox(width: 18),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: PopupMenuButton<Group>(
                      initialValue: dropdownValue,
                      itemBuilder: (_) => const [
                        PopupMenuItem(
                          value: Group.family,
                          child: Text('Family'),
                        ),
                        PopupMenuItem(
                          value: Group.favorite,
                          child: Text('Favorite'),
                        ),
                        PopupMenuItem(
                          value: Group.custom,
                          child: Text('Custom'),
                        ),
                        PopupMenuItem(
                          value: Group.non,
                          child: Text('Non'),
                        ),
                      ],
                      onSelected: _setDropdownValue,
                      child: Row(
                        children: [
                          Text(
                            dropdownValue == Group.non
                                ? 'Select a group'
                                : dropdownValue!.name.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: AppColor.primary),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.arrow_drop_down,
                            color:
                                Theme.of(context).appBarTheme.backgroundColor,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
