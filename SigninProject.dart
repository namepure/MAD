import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui/project/loginProject.dart';
import 'package:ui/project/profileCheck.dart';

class SigninProject extends StatelessWidget {
  const SigninProject({super.key});

  @override
  Widget build(BuildContext context) {
    return const SigninProjectPage();
  }
}

class SigninProjectPage extends StatefulWidget {
  const SigninProjectPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SigninProjectPage> createState() => _SigninProjectPageState();
}

class _SigninProjectPageState extends State<SigninProjectPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController uidController = TextEditingController();
  ProfileSignin profileSignin =
      ProfileSignin(EmailSignin: '', PasswoedSignin: '', userNameSignin: '',uidSignin: '');

  final _fromKey = GlobalKey<FormState>();
  //============================================================
  String? major = 'Please select major';
  List majorselect = [
    'Please select major',
    'Computer Engineering',
    'Digital and Communication Engineering',
    'Software Engineering'
  ];
  String majorres = '';
  //============================================================
  PlatformFile? pickedFiles;
  UploadTask? uploadTask;
  XFile? _image;
  ImagePicker imagePicker = ImagePicker();
  String? downloadURL = null;

  // Future uploadFile() async {
  //   final path = 'files/${pickedFiles!.name}';
  //   final file = File(pickedFiles!.path!);
  //   final ref = FirebaseStorage.instance.ref().child(path);
  //   uploadTask = ref.putFile(file);

  //   final snapshot = await uploadTask!.whenComplete(() {});

  //   final urlDownload = await snapshot.ref.getDownloadURL();
  //   print('Downlond Link : $urlDownload');
  // }

  //===============================================
  // Future selectFile() async {
  //   final result = await FilePicker.platform.pickFiles();
  //   if (result == null) return;
  //   setState(() {
  //     pickedFiles = result.files.first;
  //   });
  // }
  selectFile() async {
    final result = await imagePicker.pickImage(source: ImageSource.gallery);
    if (result == null) return;
    setState(() {
      _image = result;
    });
  }
  //================================================

  Future<void> Singin() async {
    if (_fromKey.currentState!.validate()) {
      _fromKey.currentState?.save();
      try {
        //===========================================
        String uniqueFileName =
            DateTime.now().millisecondsSinceEpoch.toString();
        final path = 'images/$uniqueFileName';
        final fileToUpload = File(_image!.path);

        final ref = FirebaseStorage.instance.ref().child(path);
        uploadTask = ref.putFile(fileToUpload);

        final snapshot = await uploadTask!.whenComplete(() {});

        downloadURL = await snapshot.ref.getDownloadURL();
        // print("Download Link: $downloadURL");
        //==========================================
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: profileSignin.EmailSignin,
                password: profileSignin.PasswoedSignin)
            .then((value) {
          _fromKey.currentState?.reset();
          Fluttertoast.showToast(
              msg: "Creat Account Success", gravity: ToastGravity.BOTTOM);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginProject()));
          //=================================================fix
          if (profileSignin.EmailSignin.toString().length <= 27) {
            String name = profileSignin.userNameSignin;
            String email = profileSignin.EmailSignin;
            String password = profileSignin.PasswoedSignin;
            String idUsers = profileSignin.uidSignin;

            var data = {
              'name': name,
              'email': email.toLowerCase(),
              'password': password,
              'idusers': idUsers,
              'major': majorres,
              'image': downloadURL,
            };
            FirebaseFirestore.instance.collection('usersP').add(data).then(
                  (value) => print('Adding done!'),
                  onError: (e) => print('Error $e'),
                );
          }
          if (profileSignin.EmailSignin.toString().length >= 28) {
            String name = profileSignin.userNameSignin;
            String email = profileSignin.EmailSignin;
            String password = profileSignin.PasswoedSignin;
            String idUsers = profileSignin.uidSignin;
            var data = {
              'name': name,
              'email': email.toLowerCase(),
              'password': password,
              'idusers': idUsers,
              'major': majorres,
              'image': downloadURL,
            };
            FirebaseFirestore.instance.collection('users').add(data).then(
                  (value) => print('Adding done!'),
                  onError: (e) => print('Error $e'),
                );
          }
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
          'Creat Account',
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
                  CircleAvatar(
                    // backgroundColor: Color(0xFF2b2b2d),
                    backgroundColor: Colors.white,
                    radius: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (_image != null)
                          CircleAvatar(
                              radius: 40,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  File(_image!.path),
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              )),
                        if (_image == null)
                          Container(
                              child: IconButton(
                                  onPressed: () {
                                    selectFile();
                                  },
                                  icon: const Icon(
                                    Icons.add_photo_alternate,
                                    size: 40,
                                    color: Colors.black,
                                  ))),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  //========================================================================
                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: userNameController,
                    cursorColor: const Color(0xFF7d2923),
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.person, color: Color(0xFF7d2923)),
                      filled: true,
                      fillColor: Colors.white,
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Color(0xFF7d2923))),
                      hintText: 'Username',
                    ),
                    //============================================================( name
                    onSaved: (userNameController) {
                      profileSignin.userNameSignin = userNameController!;
                    },
                    //===================================================================
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Username';
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
                    controller: emailController,
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
                    //===========================================================( email
                    onSaved: (emailController) {
                      profileSignin.EmailSignin = emailController!;
                    },
                    //===================================================================
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
                    controller: uidController,
                    cursorColor: const Color(0xFF7d2923),
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.chrome_reader_mode, color: Color(0xFF7d2923)),
                      filled: true,
                      fillColor: Colors.white,
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Color(0xFF7d2923))),
                      hintText: 'UID',
                    ),
                    
                    onSaved: (uidController) {
                      profileSignin.uidSignin = uidController!;
                    },
                    
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter UID';
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
                    controller: passwordController,
                    cursorColor: const Color(0xFF7d2923),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline,
                          color: Color(0xFF7d2923)),
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
                    //====================================================( password
                    onSaved: (passwordController) {
                      profileSignin.PasswoedSignin = passwordController!;
                    },
                    //===================================================================
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
                    controller: confirmpasswordController,
                    cursorColor: const Color(0xFF7d2923),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline,
                          color: Color(0xFF7d2923)),
                      filled: true,
                      fillColor: Colors.white,
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Color(0xFF7d2923))),
                      hintText: 'Confirm Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Passwoed';
                      } else if (value != passwordController.text) {
                        return 'Password do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  //======================================================================
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.account_balance_rounded,
                          color: Color(0xFF7d2923),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        DropdownButton(
                          value: major,
                          items: majorselect
                              .map((major) => DropdownMenuItem(
                                  value: major,
                                  child: Text(
                                    major,
                                    style: TextStyle(color: Colors.black),
                                  )))
                              .toList(),
                          onChanged: (value) => setState(
                            () => major = value.toString(),
                          ),
                        ),
                      ],
                    ),
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
                  child: const Text('Creat Account'),
                  onPressed: () {
                    Singin();
                    setState(() {
                      majorres = major.toString();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
