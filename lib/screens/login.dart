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

// Invaild Email Strings/Letters
String p =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
RegExp regExp = RegExp(p);

class _LoginState extends State<Login> {
// A popup message that displays at the bottom of the screen using scaffoldMessengerKey
  static const snackBarValid = SnackBar(
    content: Text('Processing'),
    backgroundColor: Colors.blue,
    shape: StadiumBorder(),
    padding: EdgeInsets.all(10),
    behavior: SnackBarBehavior.floating,
  );

  FirebaseAuth auth = FirebaseAuth.instance;
  var email;
  var username;
  var password;
  var phoneNumber;

  bool obscureText = true;

  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final _formKey = GlobalKey<FormState>();

  void _validation() async {
    bool isvalid;
    isvalid = _formKey.currentState!.validate();
    print(isvalid);

    if (isvalid) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(snackBarValid);
      try {
        final Authresult = await auth.signInWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );
      } on FirebaseAuthException catch (e) {
        print('Failed with error code: ${e.code}');
        print(e.message);
      }
    }
  }

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
          Form(
            key: _formKey,
            child: MyTextFormField(
              validator: (value) {
                if (!regExp.hasMatch(value!)) {
                  print(value);
                  return 'Email is Invaild';
                }
                return 'error';
              },
              name: 'Email',
              onChanged: (value) {
                setState(() {
                  email = value;
                  print(email);
                });
              },
              onSaved: (value) {
                email = value;
              },
            ),
          ),
          PasswordTextFormField(
            validator: (value) {
              if (value!.isEmpty || value.length < 8) {
                return "Password Is Empty or Too Short";
              } else {
                return null;
              }
            },
            name: 'Password',
            obscureText: obscureText,
            onChanged: (value) {
              setState(() {
                password = value;
                print(password);
              });
            },
            onSaved: (value) {
              password = value;
            },
            keyboardType: const TextInputType.numberWithOptions(
                signed: true, decimal: true),
            onTap: () {
              FocusScope.of(context).unfocus();
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
          MyButton(
            name: 'Login',
            onPressed: () {
              _validation();
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
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildAllPart(),
            ],
          ),
        ),
      ),
    );
  }
}
