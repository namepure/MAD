import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'DrawerFunctionProfessor.dart';

class ProfileProfessor extends StatelessWidget {
  const ProfileProfessor({super.key});

  @override
  Widget build(BuildContext context) {
    return ProlieProfessorPage();
  }
}

class ProlieProfessorPage extends StatefulWidget {
  const ProlieProfessorPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProlieProfessorPage> createState() => _ProlieProfessorPageState();
}

class _ProlieProfessorPageState extends State<ProlieProfessorPage> {
  final authEmail = FirebaseAuth.instance;
  final _userStream =
      FirebaseFirestore.instance.collection('usersP').snapshots();
  TextEditingController userNameController = TextEditingController();
  TextEditingController uidController = TextEditingController();
  TextEditingController majorController = TextEditingController();

  //=============================================
  PlatformFile? pickedFiles;
  UploadTask? uploadTask;

  Future uploadFile() async {
    final path = 'files/${pickedFiles!.name}';
    final file = File(pickedFiles!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Downlond Link : $urlDownload');
  }

  //===============================================
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFiles = result.files.first;
    });
  }

  //===================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      drawer: const DrawerFunctionProfessor(),
      body: StreamBuilder<QuerySnapshot>(
          stream: _userStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Connection error');
            }

            // Connecting...
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading. . .');
            }

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) {
                  var docs =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  var docID = snapshot.data!.docs[index].id;
                  String im = docs['image'];
                  if (authEmail.currentUser!.email.toString() ==
                      docs['email']) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage('${im}'),
                              radius: 40,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              docs['name'],
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            //===========================================name
                            TextFormField(
                              style: const TextStyle(color: Colors.black),
                              controller: userNameController,
                              cursorColor: const Color(0xFF7d2923),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person_rounded,
                                    color: Color(0xFF7d2923)),
                                filled: true,
                                fillColor: Colors.white,
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF7d2923))),
                                hintText: '${docs['name']}',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                        color: Colors.black, fontSize: 18),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            //============================================================gmail
                            Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.email,
                                        color: Color(0xFF7d2923)),
                                  ),
                                  Text(
                                    authEmail.currentUser!.email.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                            color: Colors.black, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            //=================================================uid
                            TextFormField(
                              style: const TextStyle(color: Colors.black),
                              controller: uidController,
                              cursorColor: const Color(0xFF7d2923),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.chrome_reader_mode,
                                    color: Color(0xFF7d2923)),
                                filled: true,
                                fillColor: Colors.white,
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF7d2923))),
                                hintText: '${docs['idusers']}',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                        color: Colors.black, fontSize: 18),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            //-=========================================major
                            TextFormField(
                              style: const TextStyle(color: Colors.black),
                              controller: majorController,
                              cursorColor: const Color(0xFF7d2923),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                    Icons.account_balance_rounded,
                                    color: Color(0xFF7d2923)),
                                filled: true,
                                fillColor: Colors.white,
                                border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF7d2923))),
                                hintText: '${docs['major']}',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                        color: Colors.black, fontSize: 18),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            //==============================================ele
                            Container(
                                height: 50,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ElevatedButton(
                                  child: Text(
                                    'Edit Profile',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      String _name = userNameController.text;
                                      String _uid = uidController.text;
                                      String _major = majorController.text;

                                      var data = {
                                        'name': _name,
                                        'idusers': _uid,
                                        'major': _major,
                                      };
                                      FirebaseFirestore.instance
                                          .collection('usersP')
                                          .doc(docID)
                                          .update(data)
                                          .then(
                                            (value) => print('Updating done!'),
                                            onError: (e) => print('Error $e'),
                                          );
                                    });
                                  },
                                )),
                          ],
                        ),
                      ),
                    );
                  }
                  return Container();
                }));
          }),
    );
  }
}
