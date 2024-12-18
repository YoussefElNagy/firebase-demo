//
//
// import 'package:firebase/screens/addcard.dart';
// import 'package:firebase/screens/editcard.dart';
// import 'package:firebase/screens/home.dart';
// import 'package:firebase/screens/login.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
//
// void firebaseInit() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
// }
//
// void main() {
//   firebaseInit();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'App',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSwatch().copyWith(
//           primary: Color(0xFF4ecdc4),
//           secondary: Color(0xFF292f36),
//           tertiary: Color(0xFFBEEFEB),
//           surface: Color(0xFFfdfdfd),
//         ),
//         appBarTheme: AppBarTheme(
//           backgroundColor: Color(0xFFfdfdfd),
//           iconTheme: IconThemeData(color: Color(0xFF4ecdc4)),
//         ),
//         bottomNavigationBarTheme: BottomNavigationBarThemeData(
//           backgroundColor: Color(0xFFfdfdf6),
//           unselectedItemColor: Color(0xFF9FE5DF),
//           selectedItemColor: Color(0xFF4ecdc4),
//         ),
//         textTheme: TextTheme(
//           bodyLarge: TextStyle(
//               color: Color(0xFF292f36),
//               fontSize: 18,
//               fontWeight: FontWeight.w700),
//           bodyMedium: TextStyle(
//               color: Color(0xFF292f36),
//               fontSize: 16,
//               fontWeight: FontWeight.w400),
//           titleLarge: TextStyle(
//             color: Color(0xFF292f36),
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//           headlineLarge: TextStyle(
//             color: Color(0xFF292f36),
//             fontWeight: FontWeight.w600,
//           ),
//           headlineMedium: TextStyle(
//             color: Color(0xFF292f36),
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         inputDecorationTheme: InputDecorationTheme(
//           filled: true,
//           fillColor: Color(0xFFfdfdfd),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(color: Color(0xFF4ecdc4), width: 2),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(color: Color(0xFF4ecdc4), width: 2),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(color: Colors.grey, width: 2),
//           ),
//           labelStyle: TextStyle(color: Color(0x69292f36)),
//           floatingLabelStyle: TextStyle(
//             color: Color(0xFF4ecdc4),
//           ),
//         ),
//       ),
//       home: LoginScreen(),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // For the User class
import 'JulScreens/Authenticate/Register.dart';
import 'JulScreens/Authenticate/RegisterExample.dart';
import 'JulScreens/Authenticate/SignIn.dart';
import 'JulScreens/Authenticate/SignInExample.dart';
import 'JulScreens/Services/auth.dart';
import 'JulScreens/wrapper.dart';

// Screens
import 'JulScreens/Home/HomePage.dart';
import 'JulScreens/Home/ProfilePage.dart';
import 'JulScreens/Home/Event_List.dart';
import 'JulScreens/Home/Gift_List.dart';
import 'JulScreens/Home/GiftDetails.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>(
      create: (context) => AuthService().userStm,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => Wrapper(), // Decides between HomePage and Authenticate
          '/route1': (context) => HomePage(),
          '/route2': (context) => ProfilePage(),
          '/route3': (context) => EventListPage(),
          '/route4': (context) => GiftListPage(),
          '/route5': (context) => GiftDetailsPage(),
          '/register': (context) => RegisterScreen(),
          '/SignIn': (context) => Sign_In(),
        },
      ),
    );
  }
}
