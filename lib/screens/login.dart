import 'package:e_commerce/screens/signUp.dart';
import 'package:e_commerce/widgets/changescreen.dart';
import 'package:e_commerce/widgets/myTextFormField.dart';
import 'package:e_commerce/widgets/passwordTextFormField.dart';
import 'package:flutter/material.dart';
import '../widgets/mybutton.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

String p =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

RegExp regExp = RegExp(p);

void validation() {
  final FormState? _form = _formKey.currentState;
  if (_form!.validate()) {
    print('Yes');
  } else {
    print('No');
  }
}

bool obserText = true;

class _LoginState extends State<Login> {
  Widget _buildAllPart() {
    return Container(
      height: 300,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Login',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          MyTextFormField(
            validator: (value) {
              if (value == '') {
                return 'Please Enter Email';
              } else if (!regExp.hasMatch(value!)) {
                return 'Email is Invaild';
              }
              return '';
            },
            name: 'Email',
          ),
          PasswordTextFormField(
            obserText: obserText,
            validator: (value) {
              if (value == '') {
                return 'Please Enter Password';
              } else if (value!.length < 8) {
                return 'Password Is Too Short';
              }
              return '';
            },
            name: 'Password',
            onTap: () {
              FocusScope.of(context).unfocus();
              setState(() {
                obserText = !obserText;
              });
            },
          ),
          MyButton(
            name: 'Login',
            onPressed: () {
              validation();
            },
          ),
          ChangeScreen(
            name: 'SignUp',
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const SignUp(),
                ),
              );
            },
            whichAccount: 'Dont Have An Account?',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAllPart(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
