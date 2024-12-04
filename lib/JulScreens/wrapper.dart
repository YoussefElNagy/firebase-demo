import 'package:firebase/JulScreens/authenticate/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase/JulScreens/Home/HomePage.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    print(user);

    if (user == null) {
      return Authenticate();
    } else {
      return HomePage();
    }

    return Container(); // 3shan dart not expecting null
  }
}
