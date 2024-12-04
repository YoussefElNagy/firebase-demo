import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:firebase/JulScreens/Authenticate/SignIn.dart';
import 'package:firebase/JulScreens/Services/auth.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _SignupPageState();
}

class _SignupPageState extends State<RegisterScreen> {
  String Email = '';
  String Password = '';
  String Error ='';

  final AuthService _auth = AuthService();  // instance of AuthService to use email/password services
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool rememberme = false;

  @override
  void dispose() {
    _namecontroller.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Container(
            width: 350,
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white.withOpacity(0.5),
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10,
                  sigmaY: 10,
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Sign-Up",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          onChanged: (val){
                            setState(() {
                              Email = val;
                            });
                          },
                          style: const TextStyle(color: Colors.white),
                          controller: _emailcontroller,
                          decoration: const InputDecoration(
                            hintText: "Email..",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 145, 145, 145),
                                fontSize: 18),
                          ),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          onChanged: (val){
                            setState(() {
                              Password = val;
                            });
                          },

                          style: const TextStyle(color: Colors.white),
                          controller: _passwordcontroller,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: "Password..",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 145, 145, 145),
                                fontSize: 18),
                          ),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: rememberme,
                              onChanged: (bool? value) {
                                setState(() {
                                  rememberme = value ?? false;
                                });
                              },
                            ),
                            const Text(
                              "Remember me",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          height: 50,
                          minWidth: 350,
                          splashColor: const Color.fromARGB(255, 179, 136, 235),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 10,
                          color: const Color.fromARGB(255, 255, 254, 254),
                          onPressed: () async{
                            if (_formKey.currentState!.validate()){
                             dynamic result = await _auth.registerwithEmailAndPassword(Email, Password) ;
                             if(result == null){
                               setState(() {
                                 Error = 'Please Sign in with valid email';
                               });

                             }
                             else{
                               print('User Created Successfully'); ///Here , automatically will go to homePage as state will not be null in wrapper
                             }
                            }

                          },
                          child: const Text(
                            "Signup",
                            style: TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already Have Account ?",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(context,"/SignIn");
                              },
                              child: const Text(
                                " LogIn",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
