import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Forgot_Password_Verify extends StatelessWidget {
  const Forgot_Password_Verify({super.key});

  @override
  Widget build(BuildContext context) {
    return Forgot_Password_Verify_Page();
  }
}

class Forgot_Password_Verify_Page extends StatefulWidget {
  const Forgot_Password_Verify_Page({
    Key? key,
  }) : super(key: key);

  @override
  State<Forgot_Password_Verify_Page> createState() =>
      _Forgot_Password_Verify_PageState();
}

class _Forgot_Password_Verify_PageState
    extends State<Forgot_Password_Verify_Page> {
  TextEditingController ForgotpasswordController = TextEditingController();
  TextEditingController ForgotconfirmpasswordController =
      TextEditingController();
  final _fromKey = GlobalKey<FormState>();

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
              Column(
                children: [
                  //========================================================================

                  const SizedBox(
                    height: 16,
                  ),
                  //========================================================================
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    obscureText: true,
                    controller: ForgotpasswordController,
                    cursorColor: const Color(0xFF30eb4b),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline,
                          color: Color(0xFF30eb4b)),
                      filled: true,
                      fillColor: Colors.white,
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Color(0xFF30eb4b))),
                      hintText: 'Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Passwoed';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  //========================================================================
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    obscureText: true,
                    controller: ForgotconfirmpasswordController,
                    cursorColor: const Color(0xFF30eb4b),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline,
                          color: Color(0xFF30eb4b)),
                      filled: true,
                      fillColor: Colors.white,
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Color(0xFF30eb4b))),
                      hintText: 'Confirm Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Passwoed';
                      } else if (value != ForgotpasswordController.text) {
                        return 'Password do not match';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              //========================================================================
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Change Password'),
                    onPressed: () {
                      if (_fromKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Change Password Success'),
                        ));
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
