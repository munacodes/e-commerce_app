import 'package:e_commerce/screens/signUp.dart';
import 'package:e_commerce/widgets/widgetsExport.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

// Invaild Email Strings/Letters
String p =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
RegExp regExp = RegExp(p);

// A popup message that displays at the bottom of the screen using scaffoldMessengerKey
const snackBar = SnackBar(
  content: Text('Already In Use'),
);

String? email;
String? password;

void validation() async {
  final FormState? _form = _formKey.currentState;
  if (_form!.validate()) {
    try {
      UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      print(result.user!.uid);
    } on PlatformException catch (e) {
      print(e.message.toString());
      _scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
    }
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
            onChanged: (value) {
              setState(() {
                email = value;
                print(email);
              });
            },
          ),
          PasswordTextFormField(
            obserText: obserText,
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
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
        key: _scaffoldMessengerKey,
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
