import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui/project/acceptCheck.dart';
import 'package:ui/project/professorNav.dart';
import 'DrawerFunctionProfessor.dart';

class Appointment_pending extends StatelessWidget {
  const Appointment_pending({super.key});

  @override
  Widget build(BuildContext context) {
    return AppointmentPage();
  }
}

class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  final _userStream =
      FirebaseFirestore.instance.collection('databook').snapshots();

  String nameSearch = "";
  final authEmail = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('การนัดหมายที่รออนุมัติ'),
      ),
      drawer: const DrawerFunctionProfessor(),
      //=================================================================================
      body: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(40, 40),
                ),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => ProfessorNavr()));
                },
                child: const Icon(Icons.arrow_back_sharp),
              ),
              //==============================================================================
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextField(
                  cursorColor: const Color(0xFF7d2923),
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(color: Color(0xFF7d2923)),
                    labelText: 'Search',
                    suffixIcon: Icon(
                      Icons.search,
                      color: Color(0xFF7d2923),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF7d2923)),
                      // borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      nameSearch = val;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,    
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(80, 40),
                ),
                onPressed: () {
                  setState(() {
                    nameSearch = 'Pending';
                  });
                },
                child: Text('Pending'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(80, 40),
                ),
                onPressed: () {
                  setState(() {
                    nameSearch = 'Pass';
                  });
                },
                child: Text('Pass'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(80, 40),
                ),
                onPressed: () {
                  setState(() {
                    nameSearch = 'Reject';
                  });
                },
                child: Text('Reject'),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _userStream,
            builder: (context, snapshot) {
              // Connection error
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

              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    var docs = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    var docID = snapshot.data!.docs[index].id;
                    // String im = docs['image'];

                    if (authEmail.currentUser!.email.toString() ==
                        docs['emailp']) {
                      //=====================================================fix test
                      if (nameSearch.isEmpty) {
                        return AppointmentPageFunction(
                          docs: docs,
                          docId: docID,
                        );
                      }
                      if (docs['nameS']
                          .toString()
                          .toLowerCase()
                          .startsWith(nameSearch.toLowerCase())) {
                        return AppointmentPageFunction(
                          docs: docs,
                          docId: docID,
                        );
                      }
                      if (docs['status']
                          .toString()
                          .toLowerCase()
                          .startsWith(nameSearch.toLowerCase())) {
                        return AppointmentPageFunction(
                          docs: docs,
                          docId: docID,
                        );
                      }
                    }

                    return Container();
                  }),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AppointmentPageFunction extends StatelessWidget {
  final Map<String, dynamic> docs;
  final String docId;
  // final String im;

  AppointmentPageFunction({
    Key? key,
    required this.docs,
    required this.docId,
    // required this.im,
  }) : super(key: key);

  final _tcannotationP = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () async {
          String? answer = await showDialog(
            context: context,
            builder: (context) {
              //=========================================================
              return AlertDialog(
                backgroundColor: const Color(0xFF2b2b2d),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name : ${docs['nameS']}',
                      style: const TextStyle(
                        color: Color(0xFF7d2923),
                      ),
                    ),
                    Text(
                      'Date : ${docs['date']}',
                      style: TextStyle(color: const Color(0xFF7d2923)),
                    ),
                    Row(
                      children: [
                        Text(
                          '${docs['timeSart']}  to  ',
                          style: TextStyle(color: Color(0xFF7d2923)),
                        ),
                        Text(
                          '${docs['timeEnd']}',
                          style: TextStyle(color: Color(0xFF7d2923)),
                        ),
                      ],
                    ),
                    Text(
                      'Location : ${docs['location']}',
                      style: TextStyle(color: Color(0xFF7d2923)),
                    ),
                    Text(
                      'Status  :  ${docs['status']}',
                      style: const TextStyle(color: Color(0xFF7d2923)),
                    ),
                    // Text(
                    //   'Annotation  :  ${docs['annotation']}',
                    //   style: const TextStyle(color: Color(0xFF7d2923)),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'หมายเหตุ?',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:  [
                    TextField(
                      controller: _tcannotationP,
                      decoration: InputDecoration(),
                    ),
                  ],
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop('Pass');
                        },
                        child: const Text('Pass'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop('Reject');
                        },
                        child: const Text(
                          'Reject',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
          if (answer == 'Pass') {
            String status = 'Pass';
            String? annotation = _tcannotationP.text;
            var data = {'status': status ,'annotationP': annotation};
            FirebaseFirestore.instance
                .collection('databook')
                .doc(docId)
                .update(data)
                .then(
                  (value) => print('Updating done!'),
                  onError: (e) => print('Error $e'),
                );
          }

          if (answer == 'Reject') {
            String status = 'Reject';
             String? annotation = _tcannotationP.text;
             var data = {'status': status ,'annotationP': annotation};
            FirebaseFirestore.instance
                .collection('databook')
                .doc(docId)
                .update(data)
                .then(
                  (value) => print('Updating done!'),
                  onError: (e) => print('Error $e'),
                );
          }
        },
        child: ListTile(
          title: Row(
            children: [
              // CircleAvatar(
              //   backgroundImage: NetworkImage('${im}'),
              //   radius: 40,
              // ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Name :  ",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        '${docs['nameS']}',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Colors.white),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Status  : ',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        ' ${docs['status']}',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
