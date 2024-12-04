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
          '/': (context) => RegisterScreen(), // Decides between HomePage and Authenticate
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
