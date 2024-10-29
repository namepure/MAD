import 'package:flutter/material.dart';

import 'package:ui/project/Report_visitNav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Appointment_pendingNav.dart';
import 'DrawerFunctionProfessor.dart';

class Professor extends StatelessWidget {
  const Professor({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfessorPage();
  }
}

//=================================================================================
class ProfessorPage extends StatefulWidget {
  @override
  _ProfessorPageState createState() => _ProfessorPageState();
}

class _ProfessorPageState extends State<ProfessorPage> {
  int _selectedItem = 0;
  final authEmail = FirebaseAuth.instance;
  final _userStream =
      FirebaseFirestore.instance.collection('usersP').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //================================================================
      drawer: const DrawerFunctionProfessor(),
      appBar: AppBar(),
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
                      style: TextStyle(color: Colors.black),
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
                                      .headlineMedium!.copyWith(color: Colors.black),
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
                                            builder: (context) =>
                                                Appointment_pendingNavr(),
                                            // settings: RouteSettings(
                                            //     arguments: docs[index]),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'การนัดหมายที่รออนุมัติ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge?.copyWith(color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    //==================================================================Report การเข้าพบ
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: Size(250, 40)),
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Report_ProfessorNavr()));
                                      },
                                      child: Text(
                                        'View Report',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge?.copyWith(color: Colors.white),
                                      ),
                                    ),
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
