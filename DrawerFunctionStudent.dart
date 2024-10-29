import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui/project/loginProject.dart';
import 'package:ui/project/studentNve.dart';

import 'Profilestudent.dart';

class DrawerFunctionStudent extends StatefulWidget {
  const DrawerFunctionStudent({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerFunctionStudent> createState() => _DrawerFunctionStudentState();
}

class _DrawerFunctionStudentState extends State<DrawerFunctionStudent> {
  final authEmail = FirebaseAuth.instance;
  final _userStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _userStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Connection error');
        }

        // Connecting...
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading. . .');
        }
        return Drawer(
          child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: ((context, index) {
                var docs =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                var docID = snapshot.data!.docs[index].id;
                String im = docs['image'];
                if (authEmail.currentUser!.email.toString() == docs['email']) {
                  return Column(
                    children: [
                      DrawerHeader(
                        decoration: BoxDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              // photo
                              backgroundImage: NetworkImage('${im}'),
                              radius: 40,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              docs['name'],
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Expanded(
                              child: Text(
                                authEmail.currentUser!.email.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentNavr()));
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text('Home',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(color: Colors.white)),
                          ],
                        ),
                      ),
                      //================================================================================
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const Profilestudent()));
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text('Profile',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(color: Colors.white)),
                          ],
                        ),
                      ),
                      //=================================================================
                      TextButton(
                        onPressed: () {
                          authEmail.signOut().then((value) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LoginProject()));
                          });
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.logout_outlined,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text('LOGOUT',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return Container();
              })),
        );
      },
    );
  }
}
