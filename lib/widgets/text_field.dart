import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Textfield extends StatelessWidget {
  final String hint;
  final int? maxLength;
  final String? errorText;
  final IconData? icon;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  const Textfield({
    Key? key,
    required this.hint,
    this.controller,
    this.onChanged,
    this.inputFormatters,
    this.icon,
    this.errorText,
    this.validator,
    this.keyboardType,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            onChanged: onChanged,
            validator: validator,
            inputFormatters: inputFormatters,
            maxLength: maxLength,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).appBarTheme.foregroundColor),
            decoration: InputDecoration(
              hintText: hint,
              counterText: '',
              errorText: errorText,
            ),
          ),
        ),
      ],
    );
  }
}
