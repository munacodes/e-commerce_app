import 'package:e_commerce/screens/screensExport.dart';
import 'package:e_commerce/widgets/widgetsExport.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

// Invaild Email Strings/Letters
String p =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
RegExp regExp = RegExp(p);

bool obserText = true;
String email;
String password;

// A popup message that displays at the bottom of the screen scaffoldMessengerKey
const snackBar = SnackBar(
  content: Text('Already In Use'),
);

class _SignUpState extends State<SignUp> {
  void validation() async {
    final FormState? _form = _formKey.currentState;
    if (!_form!.validate()) {
      try {
        AuthResult result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
      } on PlatformException catch (e) {
        print(e.message.toString());
        _scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
      }

      print(result.user.uid);
    } else {}
  }

  Widget _buildAllTextFormField() {
    return Container(
      height: 330,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyTextFormField(
            validator: (value) {
              if (value == "") {
                return "Please Fill UserName";
              } else if (value!.length < 6) {
                return "UserName Is Too Short";
              }
              return "";
            },
            name: 'UserName',
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
            validator: (value) {
              if (value == '') {
                return 'Please Enter Password';
              } else if (value!.length < 8) {
                return 'Password Is Too Short';
              }
              return '';
            },
            name: 'Password',
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
          MyTextFormField(
            validator: (value) {
              if (value == "") {
                return "Please Enter Phone Number";
              } else if (value!.length < 11) {
                return "Phone Number Must be 11";
              }
              return "";
            },
            name: 'Phone Number',
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
          MyButton(
            name: 'SignUp',
            onPressed: () {
              validation();
            },
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
