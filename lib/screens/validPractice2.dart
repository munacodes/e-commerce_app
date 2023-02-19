import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ValidPractice2 extends StatefulWidget {
  const ValidPractice2({Key? key}) : super(key: key);

  @override
  State<ValidPractice2> createState() => _ValidPractice2State();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

// Invaild Email Strings/Letters
String p =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
RegExp regExp = RegExp(p);

bool obserText = true;

FirebaseAuth auth = FirebaseAuth.instance;
var email;
var username;
var password;
var phoneNumber;

// A popup message that displays at the bottom of the screen scaffoldMessengerKey
const snackBar = SnackBar(
  content: Text('Already In Use'),
  backgroundColor: Colors.red,
);

void _trysubmit() async {
  BuildContext context;
  bool isvalid;
  isvalid = _formKey.currentState!.validate();

  if (isvalid) {
    _formKey.currentState!.save();
    try {
      final Authresult = await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on PlatformException catch (e) {
      _scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
    } catch (err) {
      String message = 'error';
      print(message);
    }
  }
}

class _ValidPractice2State extends State<ValidPractice2> {
  Widget _buildAllTextFormField() {
    return Container(
      height: 330,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextFormField(
            validator: (value) {
              if (value!.isEmpty || value.length < 5) {
                return "UserName is Empty or Too Short";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(labelText: 'UserName'),
            onSaved: (value) {
              username = value;
            },
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty ||
                  value.contains('@') ||
                  !regExp.hasMatch(value)) {
                return "Enter Vaild Email";
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              setState(() {
                email = value;
                print(email);
              });
            },
            decoration: const InputDecoration(labelText: 'Email'),
            onSaved: (value) {
              email = value;
            },
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty || value.length < 7) {
                return "Password Is Empty or Too Short";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(labelText: 'Password'),
            onSaved: (value) {
              password = value;
            },
            obscureText: true,
            onChanged: (value) {
              setState(() {
                password = value;
                print(password);
              });
            },
            onTap: () {
              FocusScope.of(context).unfocus();
              setState(() {
                obserText = !obserText;
              });
            },
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty || value.length < 11) {
                return "Phone Number is Empty or Too Short";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(labelText: 'Phone Number'),
            onSaved: (value) {
              username = value;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildButtonPart() {
    return Container(
      height: 400,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildAllTextFormField(),
          const ElevatedButton(
            onPressed: _trysubmit,
            child: Text('Register'),
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
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 220,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildButtonPart(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
