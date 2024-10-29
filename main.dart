import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui/Test/Test10.dart';
import 'package:ui/Test/Testim.dart';
import 'package:ui/Test/test1.dart';
import 'package:ui/Test/test3.dart';
import 'package:ui/Test/test5.dart';
import 'package:ui/Test/test6.dart';
import 'package:ui/Test/testm.dart';

import 'package:ui/design/baking.dart';

import 'package:ui/design/baking_login.dart';
import 'package:ui/design/recipe.dart';
import 'package:ui/design/tourist_place.dart';
import 'package:ui/firebase/read_listview.dart';
import 'package:ui/firebase_a/autLogin.dart';

import 'package:ui/project/Appointment_pending.dart';
import 'package:ui/project/ProfileProfessor.dart';
import 'package:ui/project/Report_Professor.dart';
import 'package:ui/project/calendar.dart';
import 'package:ui/project/loginProject.dart';
import 'package:ui/project/professor.dart';
import 'package:ui/project/professorNav.dart';


import 'package:ui/project/studentNve.dart';
import 'package:ui/project/studentbook.dart';
import 'package:ui/provider/%E0%B8%82%E0%B8%AD%E0%B8%87%E0%B8%AD%E0%B8%B2%E0%B8%88%E0%B8%B2%E0%B8%A3%E0%B9%8C.dart';
import 'package:ui/provider/cart.dart';
import 'package:ui/provider/cdata.dart';
import 'package:ui/provider/count.dart';
import 'package:ui/provider/counter.dart';
import 'package:ui/provider/question1.dart';
import 'package:ui/provider/shop.dart';

import 'package:ui/test.dart';
import 'package:ui/validation_focus/form_validation.dart';
import 'package:ui/validation_focus/listview_demo.dart';

import 'Test/DTesth.dart';
import 'Test/Drotest.dart';
import 'Test/LabTTest2.dart';
import 'Test/LabTest2.dart';
import 'Test/LabTest2_2.dart';
import 'Test/LoginTest/login_page.dart';
import 'Test/TestFFFF.dart';
import 'Test/scroll.dart';
import 'Test/searchTest.dart';
import 'Test/testlv.dart';
import 'firebase/crud_demo.dart';
import 'firebase/read_demo.dart';

//========================================================================================
// void main() {
//   runApp(const Center(
//     child: Text(
//       'Holy Shotgun',
//       textDirection: TextDirection.ltr,
//       style: TextStyle(fontSize: 30, color: Colors.purple),
//     ),
//   ));
// }

//========================================================================================
// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       appBar: AppBar(title: const Text('Holy Shotgun')), // ข้างบนApp
//       body: const Text('Rainden'),
//       floatingActionButton: const FloatingActionButton(
//         onPressed: null,
//         child: Text('Fox'),
//       ),
//     ),
//   ));
// }

//========================================================================================
// void main() {
//   runApp(ChangeNotifierProvider(//เอาไว้คลุกทั้งหมดเพื่อไห้อัพเดตค่าได้และเป็นตัวกลางเก็บค่า
//     create: ((context) =>Cart()), // ต้องสร้างมาเพื่อบอกว่านี่Classที่เราจะใช้อัพเดตค่า

//     child: const MaterialApp(
//       home: Question1(),
//       debugShowCheckedModeBanner: false,
//     ),
//   ));
// }

//========================================================================================
//Provider function
// void main() {
//   runApp(ChangeNotifierProvider(//เอาไว้คลุกทั้งหมดเพื่อไห้อัพเดตค่าได้และเป็นตัวกลางเก็บค่า
//     create: ((context) =>Cdata2()), // ต้องสร้างมาเพื่อบอกว่านี่Classที่เราจะใช้อัพเดตค่า

//     child: const MaterialApp(
//       home: Q1(),
//       debugShowCheckedModeBanner: false,
//     ),
//   ),);
// }

//========================================================================================
// Firebase function
// Future<void> main() async {
//   WidgetsFlutterBinding
//       .ensureInitialized(); // เรียก library ทั้งหมดก่อนค่อย Run App // ต้องไส่ตรงนี้ก่อนถึงจะRun ได้
//   await Firebase.initializeApp(); // เรียก firebase Database

//   runApp(
//     MaterialApp(
//       home: Baking(),
//       debugShowCheckedModeBanner: false,
//     ),
//   );
// }
// //========================================================================================
// Future<void> main() async {
//   WidgetsFlutterBinding
//       .ensureInitialized(); // เรียก library ทั้งหมดก่อนค่อย Run App // ต้องไส่ตรงนี้ก่อนถึงจะRun ได้
//   await Firebase.initializeApp(); // เรียก firebase Database

//   runApp(
//     MaterialApp(
//       home: Baking(),
//       debugShowCheckedModeBanner: false,
//       //=================================================================================
//       theme: ThemeData( //Theme Set
//           scaffoldBackgroundColor: bgColor,
//           //=================================================================================
//           textTheme: const TextTheme( //Text Theme
//             headlineMedium: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//             //=================================================================================
//             titleLarge: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.normal,
//             ),
//             titleMedium: TextStyle( //ตัวหนังสือตอนพิม
//               color: Colors.white,
//               fontWeight: FontWeight.normal,
//             ),
//           ),
//           //=================================================================================
//           elevatedButtonTheme: ElevatedButtonThemeData(//ElevatedButton Theme
//             style: ElevatedButton.styleFrom(
//               backgroundColor: primaryColor,
//               foregroundColor: Colors.black,
//               shape: const StadiumBorder(side: BorderSide.none),
//               padding: const EdgeInsets.all(16),
//             ),
//           ),
//           //=================================================================================
//           inputDecorationTheme: InputDecorationTheme(// input Theme
//             hintStyle: TextStyle(color: textFieldColor), // Text
//             prefixIconColor: primaryColor, //icon
//             enabledBorder: UnderlineInputBorder( // line
//               borderSide: BorderSide(color: textFieldColor),
//             ),
//           )),
//     ),
//   );
// }

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       //เอาไว้คลุกทั้งหมดเพื่อไห้อัพเดตค่าได้และเป็นตัวกลางเก็บค่า
//       create: ((context) =>
//           Cdata2()), // ต้องสร้างมาเพื่อบอกว่านี่Classที่เราจะใช้อัพเดตค่า

//       child: MaterialApp(
//         home: Nav(),
//         debugShowCheckedModeBanner: false,
//       ),
//     ),
//   );
// }

//=============================================================================
// class Bar extends StatefulWidget {
//   @override
//   _Bar createState() => _Bar();
// }

// class _Bar extends State<Bar> {
//   int _selectedItem = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       //=================================================================================
//       bottomNavigationBar: Row(
//         children: [
//           BarIcon(Icons.home, 0),
//           BarIcon(Icons.calendar_month, 1),
//           BarIcon(Icons.feed_outlined, 2),
//           BarIcon(Icons.account_circle_outlined, 3),
//         ],
//       ),

//       //=================================================================================
//       body: Column(),
//     );
//   }

// //=================================================================================
//   Widget BarIcon(IconData icon, int index) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedItem = index;
//           if (index == 0) {
//             Navigator.pushReplacement(context,
//                 MaterialPageRoute(builder: (context) => Professor()));
//                 index =0;
//           }
//           if (index == 1) {
//             Navigator.pushReplacement(context,
//                 MaterialPageRoute(builder: (context) => Appointment_pending()));
//                 index =1;
//           }
//           if (index == 2) {
//             Navigator.pushReplacement(context,
//                 MaterialPageRoute(builder: (context) => Report_visit()));
//                 index =2;
//           }

//         });
//       },
//       child: Container(
//         height: 60,
//         width: MediaQuery.of(context).size.width / 4,
//         decoration: index == _selectedItem
//             ? BoxDecoration(
//                 border:
//                     Border(bottom: BorderSide(width: 4, color: Colors.blue)),
//                 gradient: LinearGradient(colors: [
//                   Colors.blue.withOpacity(0.3),
//                   Colors.blue.withOpacity(0.015),
//                 ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
//                 // color: index == _selectedItem ? Colors.blue[500] : Colors.blue[300],
//               )
//             : BoxDecoration(),
//         child: Icon(
//           icon,
//           color: index == _selectedItem ? Colors.black : Colors.grey[850],
//         ),
//       ),
//     );
//   }
// }

//================================================================================
// class Nav extends StatefulWidget {
//   @override
//   _NavState createState() => _NavState();
// }

// class _NavState extends State<Nav> {
//   int _selectedIndex = 0;
//   List<Widget> _widgetOptions = <Widget>[
//     Text('Home'),
//     Text('Messgaes Screen'),
//     Text('News Screen'),
//     Text('Logout'),
//   ];

//   void _onItemTap(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.home,
//             ),
//             backgroundColor: Colors.grey,
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.calendar_month,
//             ),
//             backgroundColor: Colors.grey,
//             label: 'Calender',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.newspaper,
//             ),
//             backgroundColor: Colors.grey,
//             label: 'News',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.person,
//             ),
//             backgroundColor: Colors.grey,
//             label: 'Profile',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTap,
//         selectedFontSize: 13.0,
//         unselectedFontSize: 13.0,
//       ),
//     );
//   }
// }
//====================================================================================
// void main() {
//   runApp(
//     MaterialApp(
//       home: BakingLogin(),
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(

//           //Theme Set
// scaffoldBackgroundColor: Color.fromARGB(255,125, 41, 35),
// //=================================================================================
// textTheme: const TextTheme(
//   //Text Theme
//   headlineMedium: TextStyle(
//     color: Colors.black,
//     fontWeight: FontWeight.bold,
//   ),
//   //=================================================================================
//   titleLarge: TextStyle(
//     color: Colors.black,
//     fontWeight: FontWeight.normal,
//   ),
//   titleMedium: TextStyle(
//     //ตัวหนังสือตอนพิม
//     color: Colors.white,
//     fontWeight: FontWeight.normal,
//   ),
// ),
// //=================================================================================
// elevatedButtonTheme: ElevatedButtonThemeData(
//   //ElevatedButton Theme
//   style: ElevatedButton.styleFrom(
//     backgroundColor: Colors.white,
//     foregroundColor: Colors.black,
//     shape: const StadiumBorder(side: BorderSide.none),
//     padding: const EdgeInsets.all(16),
//   ),
// ),
// //=================================================================================
// appBarTheme: AppBarTheme(
//   backgroundColor: Color.fromARGB(255,125, 41, 35),
//   elevation: 0,
// ),

//           //=================================================================================
//           inputDecorationTheme: InputDecorationTheme(
//             // input Theme
//             hintStyle: TextStyle(color: textFieldColor), // Text
//             prefixIconColor: primaryColor, //icon
//             enabledBorder: UnderlineInputBorder(
//               // line
//               borderSide: BorderSide(color: textFieldColor),
//             ),
//           )),
//     ),
//   );
// }
//=====================================================================================
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    Home(),
  );
}

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginProject(),
      debugShowCheckedModeBanner: false,
      //=============================================================
      // - - - THEME - - -
      theme: ThemeData(
        // AppBarTheme
        appBarTheme: const AppBarTheme(
          // backgroundColor: Colors.transparent,
           backgroundColor: Color(0xFF7d2923),
          elevation: 0,
        ),

        //scaffoldBackground Theme
        // scaffoldBackgroundColor: Color(0xFF2b2b2d),
        scaffoldBackgroundColor: Color(0xFFf8f9fb),

        ////Text Theme
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),

          titleLarge: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          //ตัวหนังสือตอนพิม
          titleMedium: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),

        //ElevatedButton Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            // side: BorderSide(color: Color(0xFF16651d), width: 2),
            // backgroundColor: Color(0xFF30eb4b),
            // foregroundColor: Colors.black,
            side: BorderSide(color: Color.fromARGB(255, 87, 30, 30), width: 2),
            backgroundColor: Color(0xFF7d2923),
            foregroundColor: Colors.white,
            shape: const StadiumBorder(),
            padding: const EdgeInsets.all(8),
          ),
        ),
        //drawer Theme
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color(0xFF2b2b2d),
        ),
      ),
      //=================================================================================
    );
  }
}
