import 'package:e_commerce/screens/screensExport.dart';
import 'package:e_commerce/widgets/widgetsExport.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

// Invaild Email Strings/Letters
String p =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
RegExp regExp = RegExp(p);

bool obscureText = true;

FirebaseAuth auth = FirebaseAuth.instance;
var email;
var username;
var password;
var phoneNumber;

// A popup message that displays at the bottom of the screen scaffoldMessengerKey
const snackBarValid = SnackBar(
  content: Text('Processing'),
  backgroundColor: Colors.blue,
  margin: EdgeInsets.all(10),
);

class _SignUpState extends State<SignUp> {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final _formKey = GlobalKey<FormState>();

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
          MyTextFormField(
            validator: (value) {
              if (value!.isEmpty || value.length < 5) {
                return "UserName is Empty or Too Short";
              } else {
                return null;
              }
            },
            name: 'UserName',
            keyboardType: TextInputType.name,
            onSaved: (value) {
              username = value;
            },
            onChanged: (value) {
              username = value;
            },
          ),
          MyTextFormField(
            validator: (value) {
              if (value!.isEmpty || !regExp.hasMatch(value)) {
                return "Email Is Empty or Invaild Email";
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
            name: 'Email',
            onSaved: (value) {
              email = value;
            },
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
            onSaved: (value) {
              password = value;
            },
            obscureText: obscureText,
            onChanged: (value) {
              setState(() {
                password = value;
                print(password);
              });
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
          MyTextFormField(
            validator: (value) {
              if (value!.isEmpty || value.length < 11) {
                return "Phone Number is Empty or Too Short";
              } else {
                return null;
              }
            },
            name: 'Phone Number',
            onSaved: (value) {
              phoneNumber = value;
            },
            onChanged: (value) {
              phoneNumber = value;
            },
            keyboardType: TextInputType.phone,
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
                  builder: (ctx) => const Login(),
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
