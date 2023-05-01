import 'package:flutter/material.dart';
import 'package:contact_app/widgets/text_field.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import '../data/hive_db.dart';
import '../models/group.dart';
import '../screens/my_home_screen.dart';
import '../utils/app_color.dart';

class ContactWidget extends StatefulWidget {
  final String title;
  final String name;
  final String number;
  final String email;
  final Group group;

  const ContactWidget({
    super.key,
    this.name = '',
    this.number = '',
    this.email = '',
    required this.group,
    required this.title,
  });

  @override
  State<ContactWidget> createState() => _ContactWidgetState();
}

class _ContactWidgetState extends State<ContactWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _numberNameController;
  late final TextEditingController _emailNameController;
  var _isLoading = false;
  late Group? _dropdownValue;

  @override
  void initState() {
    _firstNameController =
        TextEditingController(text: widget.name.split(' ').first);
    _lastNameController = TextEditingController(
        text: widget.name.split(' ').first == widget.name.split(' ').last
            ? ''
            : widget.name.split(' ').last);
    _numberNameController = TextEditingController(text: widget.number);
    _emailNameController = TextEditingController(text: widget.email);
    _dropdownValue = widget.group;
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _numberNameController.dispose();
    _emailNameController.dispose();
    super.dispose();
  }

  void _setDropdownValue(Group value) {
    setState(() {
      _dropdownValue = value;
    });
  }

  void _onCreate() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await HiveDb(Hive)
          .createContact(
            '${_firstNameController.value.text} ${_lastNameController.value.text}',
            _numberNameController.value.text,
            _emailNameController.value.text,
            _dropdownValue!,
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
        elevation: 3,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context)
        .pushReplacementNamed(MyHomeScreen.id)
        .then((value) => true),
        ),
        title: Text(widget.title),
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
                controller: _firstNameController,
                hint: 'FirstName',
                icon: Icons.person,
                keyboardType: TextInputType.name,
                validator: (val) => _errorText(val!),
              ),
              const SizedBox(
                height: 24,
              ),
              Textfield(
                controller: _lastNameController,
                hint: 'LastName',
                validator: (val) => _errorText(val!),
              ),
              const SizedBox(
                height: 24,
              ),
              Textfield(
                controller: _numberNameController,
                hint: 'Phone',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (val) => _errorText(val!),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Textfield(
                controller: _emailNameController,
                hint: 'Email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (val) => _errorText(val!),
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
                      initialValue: _dropdownValue,
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
                            _dropdownValue!.name.toUpperCase(),
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
