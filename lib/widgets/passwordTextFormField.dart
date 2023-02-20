import 'package:flutter/material.dart';

class PasswordTextFormField extends StatelessWidget {
  final bool obserText;
  final Function validator;
  final String name;
  final Function onChanged;
  final Function onTap;
  final Function onSaved;

  const PasswordTextFormField(
      {Key? key,
      required this.obserText,
      required this.validator,
      required this.name,
      required this.onChanged,
      required this.onTap,
      required this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obserText,
      validator: (value) {
        validator;
      },
      onChanged: (value) {
        onChanged;
      },
      onSaved: (value) {
        onSaved;
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: name,
        suffixIcon: GestureDetector(
          onTap: () {
            onTap;
          },
          child: Icon(
            obserText == true ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
          ),
        ),
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
