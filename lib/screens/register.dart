import 'package:e_commerce/screens/screensExport.dart';
import 'package:e_commerce/widgets/widgetsExport.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final _formKey = GlobalKey<FormState>();
  Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
// Invaild Email Strings/Letters
    String p =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(p);

    var email;
    var username;
    var password;
    var phoneNumber;
    FirebaseAuth auth = FirebaseAuth.instance;

    // A popup message that displays at the bottom of the screen scaffoldMessengerKey
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

      if (isvalid) {
        _formKey.currentState!.save();
        ScaffoldMessenger.of(context).showSnackBar(snackBarValid);
        try {
          final Authresult = await auth.createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );
        } on FirebaseAuthException catch (e) {
          print('Faild with error code: ${e.code}');
          print(e.message);
        }
      }
    }

    Widget _buildAllTextFormField() {
      return Container(
        height: 330,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "UserName is Empty";
                } else if (value.length < 5) {
                  return "UserName is Too Short";
                }
                {
                  return null;
                }
              },
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(labelText: "UserName"),
              onSaved: (newValue) {
                username = newValue;
              },
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Email Is Empty";
                } else if (regExp.hasMatch(value)) {
                  return "Invaild Email";
                }
                {
                  return null;
                }
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: "Email"),
              onSaved: (value) {
                email = value;
              },
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Phone Number Is Empty";
                } else if (value.length < 8) {
                  return "Phone Number Is Too Short";
                }
                {
                  return null;
                }
              },
              decoration: const InputDecoration(labelText: "Phone Number"),
              onSaved: (value) {
                phoneNumber = value;
              },
              keyboardType: TextInputType.phone,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Password Is Empty";
                } else if (value.length < 8) {
                  return "Password Too Short";
                }
                {
                  return null;
                }
              },
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
              onSaved: (value) {
                password = value;
              },
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
              ),
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
            Container(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.lightBlue,
                  ),
                ),
                onPressed: _validation,
                child: const Text('Register'),
              ),
            ),
            ChangeScreen(
              name: 'Login',
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => Login2(),
                    /* ctx means or is a shortform of context*/
                  ),
                );
              },
              whichAccount: 'Already Have An Account?',
            ),
          ],
        ),
      );
    }

/*
 Scaffold(
  body: SafeArea(
    child: Column(),
  ),
); 
*/
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
                _buildAllTextFormField(),
                _buildButtonPart(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
