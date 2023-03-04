import 'package:e_commerce/screens/SignUp.dart';
import 'package:e_commerce/screens/screensExport.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce/provider/providerExport.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        Provider<CategoryProvider>(
          create: (context) => CategoryProvider(),
        ),
      ],
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return Login();
          }
        },
      ),
    );
  }
}
