

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui/firebase_a/autLogin.dart';
import 'package:ui/firebase_a/welcomedemo.dart';

class RememberME extends StatelessWidget {
  const RememberME({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Welcomedemo();
            } else {
              return AutLogin();
            }                                                                                                                                                                                                                                                                                     
          }),
    );
  }
}
