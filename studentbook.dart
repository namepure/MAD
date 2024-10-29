import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ui/project/student.dart';
import 'package:ui/project/studentNve.dart';

class StudentBook extends StatefulWidget {
  const StudentBook({super.key});

  @override
  State<StudentBook> createState() => _StudentBook();
}

class _StudentBook extends State<StudentBook> {
  final _userStream =
      FirebaseFirestore.instance.collection('usersP').snapshots();
  final authEmail = FirebaseAuth.instance;
  TextEditingController dateController = TextEditingController();
  TextEditingController _tcLocation = TextEditingController();
  TextEditingController _tcannotation = TextEditingController();
  final _fromKey = GlobalKey<FormState>();

  //=================================================================
  Future<void> Booking() async {
    if (_fromKey.currentState!.validate()) {
      _fromKey.currentState?.save();
      try {
        print(_timeOfDaySart.format(context).toString());
        print(
          _timeOfDayEnd.format(context).toString(),
        );
        print(dateController.text);
        print(selectedClient);
        print(nameS);
        print(nameP);

        String? _timeSart = _timeOfDaySart.format(context).toString();
        String? _timeEnd = _timeOfDayEnd.format(context).toString();
        String emailS = authEmail.currentUser!.email.toString();
        String emailP = selectedClient;
        String? location = _tcLocation.text;
        String? date = dateController.text;
        String? annotation = _tcannotation.text;
        String? annotationP = '';
        String status = 'Pending';
        var data = {
          'nameS': nameS,
          'nameP': nameP,
          'location': location,
          'date': date,
          'timeSart': _timeSart,
          'timeEnd': _timeEnd,
          'status': status,
          'emails': emailS,
          'emailp': emailP,
          'annotation': annotation,
          'annotationP': annotationP
        };

        FirebaseFirestore.instance.collection('databook').add(data).then(
              (value) => print('Adding done!'),
              onError: (e) => print('Error $e'),
            );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => StudentNavr()));
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(
            msg: e.message.toString(), gravity: ToastGravity.BOTTOM);
      }
    }
  }

//================================================================
  void initState() {
    super.initState();
    dateController.text = "";
  }

  TimeOfDay _timeOfDaySart = TimeOfDay(
    hour: 00,
    minute: 00,
  );
  TimeOfDay _timeOfDayEnd = TimeOfDay(
    hour: 00,
    minute: 00,
  );

  // show time picker method
  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _timeOfDaySart = value!;
      });
    });
  }

  //================================================================
  void _showTimePickerSecond() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _timeOfDayEnd = value!;
      });
    });
  }

  //================================================
  String selectedClient = "";
  String? nameS = '';
  String? nameP = '';

  @override
  Widget build(BuildContext context) {
    var dataName = ModalRoute.of(context)!.settings.arguments.toString();
    nameS = dataName;
    return Scaffold(
      appBar: AppBar(
        title: const Text('จองการนัดหมายอาจารย์'),
      ),
      body: Form(
        key: _fromKey,
        child: Column(
          children: [
            //====================================================================
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder<QuerySnapshot<Object?>>(
                    stream: _userStream,
                    builder: (context, snapshot) {
                      List<DropdownMenuItem> clienItem = [];
                      final data = snapshot.data!.docs.toList();
                      final Clients = snapshot.data?.docs.reversed.toList();
                      if (snapshot.hasError) {
                        return const Text('Connection error');
                      }
                      // connecting?
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text('Loading data...');
                      }
                      if (!snapshot.hasData) {
                        const CircularProgressIndicator();
                      } else {
                        //=================================== have error

                        for (int i = 0; i < data.length; i++) {
                          if (data[i]['email'] == selectedClient) {
                            nameP = data[i]['name'];
                          }
                        }
                        // final Clients = snapshot.data?.docs.reversed.toList();
                        clienItem.add(
                          const DropdownMenuItem(
                            value: "",
                            child: Text(
                              'Select Lecturer ',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                        for (var client in Clients!) {
                          clienItem.add(
                            DropdownMenuItem(
                              value: client['email'],
                              // === can change ===
                              child: Text(
                                client['name'],
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          );
                        }
                      }
                      return Container(
                        height: 2,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            DropdownButton(
                              items: clienItem,
                              onChanged: (clienValue) {
                                setState(() {
                                  selectedClient = clienValue;
                                });
                              },
                              value: selectedClient,
                              isExpanded: false,
                            ),
                            Text('Email Lecturer : ${selectedClient}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                          ],
                        ),
                      );
                    }),
              ),
            ),

            //========================================================================
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'วัน/เดือน/ปี',
                      style: TextStyle(color: Color(0xFF7d2923), fontSize: 18),
                    ),
                    Center(
                      child: (TextFormField(
                        controller: dateController,
                        cursorColor: const Color(0xFF7d2923),
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            icon: Icon(
                              Icons.calendar_today,
                              color: Color(0xFF7d2923),
                            ),
                            labelText: "เลือกวัน"),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat("yyyy-MM-dd").format(pickedDate);

                            setState(() {
                              dateController.text = formattedDate.toString();
                            });
                          } else {
                            print("Not selected");
                          }
                        },
                      )),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        //==============================================================
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                'เลือกเวลา',
                                style: TextStyle(
                                    color: Color(0xFF7d2923), fontSize: 15),
                              ),
                              Row(children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(width: 1),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text(
                                    _timeOfDaySart.format(context).toString(),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.timer_rounded,
                                      color: Color(0xFF7d2923),
                                    ),
                                    onPressed: _showTimePicker,
                                  ),
                                )
                              ]),
                            ],
                          ),
                        ),
                        //====================================================================
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                'เลือกเวลา',
                                style: TextStyle(
                                    color: Color(0xFF7d2923), fontSize: 15),
                              ),
                              Row(children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(width: 1),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text(
                                    _timeOfDayEnd.format(context).toString(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.timer_rounded,
                                      color: Color(0xFF7d2923),
                                    ),
                                    onPressed: _showTimePickerSecond,
                                  ),
                                )
                              ]),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Location',
                      style: TextStyle(color: Color(0xFF7d2923), fontSize: 22),
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: _tcLocation,
                      cursorColor: const Color(0xFF7d2923),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Color(0xFF7d2923))),
                        hintText: 'Location',
                      ),

                      //===========================================================
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Location';
                        }
                        return null;
                      },
                    ),
                    const Text(
                      'หมายเหตุการจอง',
                      style: TextStyle(color: Color(0xFF7d2923), fontSize: 22),
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: _tcannotation,
                      cursorColor: const Color(0xFF7d2923),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Color(0xFF7d2923))),
                        hintText: 'Annotation',
                      ),

                      //===========================================================
                    ),
                  ],
                ),
              ),
            ),
            //==============================================================================
            Expanded(
                flex: 1,
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(minimumSize:Size(100, 20)),
                    onPressed: Booking,
                    child: Text(
                      'ยืนยัน',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
