import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final Function validator;
  final Function? onChanged;
  final String name;
  final TextInputType? keyboardType;
  final Function onSaved;
  final bool? obserText;
  final Function? onTap;

  const MyTextFormField({
    Key? key,
    required this.validator,
    this.onChanged,
    required this.name,
    this.keyboardType,
    required this.onSaved,
    this.obserText,
    this.onTap,
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
        labelText: name,
      ),
      keyboardType: TextInputType.emailAddress,
      onSaved: ((value) {
        onSaved;
      }),
    );
  }
}
