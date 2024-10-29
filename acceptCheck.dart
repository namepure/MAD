import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileLogin {
  String EmailLogin; 
  String PasswoedLogin;

  ProfileLogin({required this.EmailLogin, required this.PasswoedLogin});
}
Future<void> editData(String answeri) async {
  final _userStream =
      FirebaseFirestore.instance.collection('uesrs').snapshots();
  StreamBuilder<QuerySnapshot>(
    stream: _userStream,
    builder: (context, snapshot) {
      var docs = snapshot.data!.docs;
      String statusTest = answeri.toString();

      return ListView.builder(
        itemCount: docs.length,
        itemBuilder: ((context, index) {
          String docId = docs[index].id;
          if (statusTest == 'Accept') {
            var data = {'status': statusTest};
            FirebaseFirestore.instance
                .collection('uesrs')
                .doc(docId)
                .update(data)
                .then(
                  (value) => print('Updating done!'),
                  onError: (e) => print('Error $e'),
                );
          }
          if (statusTest == 'Refuse') {
            String status = 'Refuse';
            var data = {'status': status};
            FirebaseFirestore.instance
                .collection('uesrs')
                .doc(docId)
                .update(data)
                .then(
                  (value) => print('Updating done!'),
                  onError: (e) => print('Error $e'),
                );
          }
          return Container();
        }),
      );
    },
  );
}

