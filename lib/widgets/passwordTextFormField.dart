import 'package:flutter/material.dart';

class PasswordTextFormField extends StatelessWidget {
  final bool obserText;
  final Function validator;
  final String name;
  final Function onTap;

  const PasswordTextFormField(
      {Key? key,
      required this.obserText,
      required this.validator,
      required this.name,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obserText,
      validator: (value) {
        validator;
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: name,
        suffixIcon: GestureDetector(
          onTap: () {
            onTap;
          },
          child: Icon(
            obserText == true ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
          ),
        ),
        hintStyle: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
