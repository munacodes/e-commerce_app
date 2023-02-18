import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final Function validator;
  final Function? onChanged;
  final String name;

  const MyTextFormField({
    Key? key,
    required this.validator,
    this.onChanged,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        validator;
      },
      onChanged: ((value) {
        onChanged;
      }),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: name,
      ),
    );
  }
}
