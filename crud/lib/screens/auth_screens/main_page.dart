import 'package:crud/screens/auth_screens/auth_page.dart';
import 'package:crud/screens/home.dart';
import 'package:crud/screens/auth_screens/login_screen.dart';
import 'package:crud/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: Auth().auth.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return Home();
          } else{
            return AuthPage();
          }
        })),
    );
  }
}