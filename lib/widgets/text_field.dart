// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Textfield extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  const Textfield({
    Key? key,
    required this.controller,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(hintText: hint),
      controller: controller,
    );
  }
}

// ignore: camel_case_types
class phoneTextField extends StatelessWidget {
  final String hint;
  const phoneTextField({
    Key? key,
    required this.hint,
    required TextEditingController controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      maxLength: 11,
      decoration: InputDecoration(
        hintText: hint,
        counterText: '',
      ),
    );
  }
}
