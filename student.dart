import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui/project/studentbook.dart';

import 'package:ui/project/Student_pending.dart';
import 'DrawerFunctionProfessor.dart';
import 'DrawerFunctionStudent.dart';

class StudenHome extends StatelessWidget {
  const StudenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return StudentPage();
  }
}

class StudentPage extends StatefulWidget {
  const StudentPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final authEmail = FirebaseAuth.instance;

  final _userStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student'),
      ),
      drawer: const DrawerFunctionStudent(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 75),
          child: StreamBuilder<QuerySnapshot>(
              stream: _userStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Connection error');
                }
                // Connecting...
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Text(
                      'Loading...',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: ((context, index) {
                      var docs = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                      var docID = snapshot.data!.docs[index].id;
                      String im = docs['image'];
                      String nameS = docs['name'];
                      //=============================================fix
                      if (authEmail.currentUser!.email.toString() ==
                          docs['email']) {
                        return Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  // photo
                                  backgroundImage: NetworkImage('${im}'),
                                  radius: 40,
                                ),
                                //=================================================================================
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  docs['name'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium?.copyWith(color: Colors.black),
                                ),
                                Text(
                                  authEmail.currentUser!.email.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(fontSize: 14,color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                //=================================================================การนัดหมายที่รออนุมัติ
                                Column(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: Size(250, 40)),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => StudentBook(),
                                            settings: RouteSettings(
                                                arguments: nameS.toString()),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'การนัดหมาย',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge?.copyWith(color: Colors.white),
                                      ),
                                    ),
                                    //====================================================================
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: Size(250, 40)),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Student_pending(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                          'อาจารย์ที่จองไว้แล้ว',style: Theme.of(context)
                                            .textTheme
                                            .titleLarge?.copyWith(color: Colors.white)),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    //==================================================================Report การเข้าพบ
                                    // ElevatedButton(
                                    //   style: ElevatedButton.styleFrom(
                                    //       minimumSize: Size(250, 40)),
                                    //   onPressed: () {
                                    //     Navigator.push(
                                    //         context,
                                    //         MaterialPageRoute(
                                    //             builder: (context) =>
                                    //                 Student_pending()));
                                    //   },
                                    //   child: Text(
                                    //     'Report',
                                    //     style: Theme.of(context)
                                    //         .textTheme
                                    //         .titleLarge,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                      return Container();
                    }));
              }),
        ),
      ),
    );
  }
}
