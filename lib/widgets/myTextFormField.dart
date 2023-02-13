import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final Function validator;
  final String name;

  const MyTextFormField({
    Key? key,
    required this.validator,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        validator;
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: name,
      ),
    );
  }
}
