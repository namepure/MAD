import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:ui/project/SigninProject.dart';
import 'package:ui/project/professorNav.dart';
import 'package:ui/project/profileCheck.dart';
import 'package:ui/project/student.dart';
import 'package:ui/project/studentNve.dart';
import 'Forgot_Password.dart';

class LoginProject extends StatelessWidget {
  const LoginProject({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginProjectPage();
  }
}

class LoginProjectPage extends StatefulWidget {
  const LoginProjectPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginProjectPage> createState() => _LoginProjectPageState();
}

class _LoginProjectPageState extends State<LoginProjectPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();
  ProfileLogin profileLogin = ProfileLogin(EmailLogin: '', PasswoedLogin: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final authEmail = FirebaseAuth.instance;

  Future<void> login() async {
    if (_fromKey.currentState!.validate()) {
      _fromKey.currentState?.save();
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: profileLogin.EmailLogin,
          password: profileLogin.PasswoedLogin,
        )
            .then((value) {
          _fromKey.currentState?.reset();
          //=====================================================fix
          if (authEmail.currentUser!.email.toString().length <= 27) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfessorNavr(),
              ),
            );
          }
          if (authEmail.currentUser!.email.toString().length >= 28) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => StudentNavr(),
              ),
            );
          }
          print(authEmail.currentUser!.email.toString().length);
        });
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(
            msg: e.message.toString(), gravity: ToastGravity.BOTTOM);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebase,
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Error'),
            ),
            body: Center(child: Text('${snapshot.error}')),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: SafeArea(
              child: Form(
                key: _fromKey,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView(
                    children: <Widget>[
                      // const Image(
                      //     width: 150,
                      //     height: 150,
                      //     image: NetworkImage(
                      //         'https://i.redd.it/capy-is-king-v0-ian6ahoqhqna1.png?s=5639c3866298be9ecffdfe3c8f34f9f8371e885e')),
                      const Image(
                          width: 150,
                          height: 150,
                          image: NetworkImage(
                              'https://archives.mfu.ac.th/wp-content/uploads/2019/06/Mae-Fah-Luang-University-2.png')),
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            'Appointment',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 30),
                          )),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.black),
                        controller: emailController,
                        cursorColor: const Color(0xFF7d2923),
                        decoration: InputDecoration(
                          prefixIconColor: const Color(0xFF7d2923),
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
                          // labelText: 'User Name',
                          // labelStyle: TextStyle(color: Color(0xFF7d2923),fontWeight: FontWeight.bold)
                        ),
                        //===========================================================( email
                        onSaved: (emailController) {
                          profileLogin.EmailLogin = emailController!;
                        },
                        //===========================================================
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
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        obscureText: true,
                        controller: passwordController,
                        cursorColor: const Color(0xFF7d2923),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: Color(0xFF7d2923),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: Color(0xFF7d2923))),
                          hintText: 'Password',
                        ),
                        //==================================================( password
                        onSaved: (passwordController) {
                          profileLogin.PasswoedLogin = passwordController!;
                        },
                        //===========================================================
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Passwoed';
                          }
                          return null;
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Forgot_Password()));
                        },
                        child: const Text(
                          'Forgot Password',
                          style: TextStyle(color: Color(0xFF7d2923)),
                        ),
                      ),
                      //=============================================fix
                      Container(
                          height: 50,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            onPressed: login,
                          )),
                      //===================================================================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Does not have account?',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextButton(
                            child: const Text(
                              'Sign in',
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xFF7d2923)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SigninProject()));
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }),
    );
  }
}
