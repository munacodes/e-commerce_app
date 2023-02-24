import 'package:e_commerce/screens/register.dart';
import 'package:e_commerce/screens/signUp.dart';
import 'package:e_commerce/widgets/widgetsExport.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login2 extends StatefulWidget {
  Login2({Key? key}) : super(key: key);

  @override
  State<Login2> createState() => _Login2State();
}

class _Login2State extends State<Login2> {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
// Invaild Email Strings/Letters
    String p =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(p);

    FirebaseAuth auth = FirebaseAuth.instance;
    var email;
    var username;
    var password;
    var phoneNumber;

    bool obscureText = true;

// A popup message that displays at the bottom of the screen using scaffoldMessengerKey
    const snackBarValid = SnackBar(
      content: Text(
        'Processing',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.blue,
      shape: StadiumBorder(),
      padding: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
    );

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
        height: 400,
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
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Field Is Empty";
                } else if (!regExp.hasMatch(value)) {
                  return "Please Enter A Valid Email";
                }
                {
                  return null;
                }
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                border: OutlineInputBorder(),
              ),
              onSaved: (value) {
                email = value;
              },
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Field Is Empty";
                } else if (value.length < 8) {
                  return "Password must have at least 8 characters";
                }
                {
                  return null;
                }
              },
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                border: const OutlineInputBorder(),
                suffixIcon: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  child: Icon(
                    obscureText == true
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
              ),
              obscureText: obscureText,
              onSaved: (value) {
                password = value;
              },
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
              ),
            ),
            MyButton(
              name: 'Login',
              onPressed: () {
                _validation();
              },
            ),
            ChangeScreen(
              name: 'Register',
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Register(),
                  ),
                );
              },
              whichAccount: 'Dont Have An Account?',
            ),
          ],
        ),
      );
    }

    return Scaffold(
      key: _scaffoldMessengerKey,
      body: SafeArea(
        child: Form(
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
