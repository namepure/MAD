import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ui/project/loginProject.dart';
import 'package:ui/project/profileCheck.dart';

import 'Forgot_Password_Verify.dart';

class Forgot_Password extends StatelessWidget {
  const Forgot_Password({super.key});

  @override
  Widget build(BuildContext context) {
    return Forgot_Password_Page();
  }
}

class Forgot_Password_Page extends StatefulWidget {
  const Forgot_Password_Page({
    Key? key,
  }) : super(key: key);

  @override
  State<Forgot_Password_Page> createState() => _Forgot_Password_PageState();
}

class _Forgot_Password_PageState extends State<Forgot_Password_Page> {
  TextEditingController ForgotemailController = TextEditingController();
  ProfileForgot profileForgot = ProfileForgot(EmailForgot: '');
  final _fromKey = GlobalKey<FormState>();
  final authEmail = FirebaseAuth.instance;

  Future<void> Forgot() async {
    if (_fromKey.currentState!.validate()) {
      try {
        await authEmail
            .sendPasswordResetEmail(
                email: ForgotemailController.text.trim().toString())
            .then((value) {
          Navigator.pop(
              context, MaterialPageRoute(builder: (context) => LoginProject()));
        });
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(
            msg: e.message.toString(), gravity: ToastGravity.BOTTOM);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forgot Password',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: Form(
        key: _fromKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Column(
                  children: [
                    //========================================================================
                    Row(
                      children: const [
                        Text(
                          'Verify Email',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: ForgotemailController,
                      cursorColor: const Color(0xFF7d2923),
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.email, color: Color(0xFF7d2923)),
                        filled: true,
                        fillColor: Colors.white,
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Color(0xFF7d2923))),
                        hintText: 'Email',
                      ),
                      onSaved: (ForgotemailController) {
                        profileForgot.EmailForgot = ForgotemailController!;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),

              //========================================================================
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Verify Email'),
                  onPressed: Forgot,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

