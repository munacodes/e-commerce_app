import 'package:e_commerce/screens/validPractice2.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class ValidPractice extends StatelessWidget {
  var email;
  var username;
  var password;
  var phonenumber;
  FirebaseAuth auth = FirebaseAuth.instance;

  ValidPractice(
      {Key? key,
      required this.email,
      required this.username,
      required this.password,
      required this.phonenumber})
      : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  // Invaild Email Strings/Letters
  String P =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regExp = RegExp(p);

  // A popup message that displays at the bottom of the screen scaffoldMessengerKey
  var snackBar = const SnackBar(
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
        if (err.message != null) {
          message = err.message;
        }
        print(message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Form(
              key: _formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty ||
                            value.contains('@') ||
                            !regExp.hasMatch(value)) {
                          return "Enter Valid Email";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: 'Email'),
                      onSaved: (value) {
                        email = value;
                      },
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || value.length < 5) {
                          return "UserName Is Empty or Too Short";
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
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || value.length < 11) {
                          return "Phone Number Is Empty or Too Short";
                        } else {
                          return null;
                        }
                      },
                      decoration:
                          const InputDecoration(labelText: 'Phone Number'),
                      onSaved: (value) {
                        phoneNumber = value;
                      },
                    ),
                    ElevatedButton(
                      onPressed: _trysubmit,
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
