import 'package:e_commerce/screens/screensExport.dart';
import 'package:e_commerce/widgets/widgetsExport.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
// Invaild Email Strings/Letters
    String p =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(p);

    bool obscureText = true;

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
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field is Empty";
                  } else if (value.length < 5) {
                    return "UserName is Too Short";
                  }
                  {
                    return null;
                  }
                },
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: "UserName",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(),
                ),
                onSaved: (newValue) {
                  username = newValue;
                },
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
                    return "Phone Number must have at least 8 characters";
                  }
                  {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  phoneNumber = value;
                },
                keyboardType: TextInputType.phone,
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
            ],
          ),
        ),
      );
    }

    Widget _buildButtonPart() {
      return Container(
        height: 100,
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
                    builder: (ctx) => Login(),
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

    return Scaffold(
      key: _scaffoldMessengerKey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 200,
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
