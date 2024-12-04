import 'package:flutter/material.dart';

import 'package:firebase/JulScreens/Services/auth.dart';

import 'SignIn.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


  String email='';
  String password= '';

  final AuthService _auth = AuthService();  //instance mn class AuthService 3shan a-use el services of class whether anonymous or email/password
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title: const Text('Sign up to Brew Crew'),
          backgroundColor: Colors.brown[400],
          actions: [
            TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/SignIn');
              },
              icon: const Icon(Icons.person, color: Colors.white),
              label: const Text(
                'Sign-In',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body:
        // Container(
        //   padding: const EdgeInsets.all(20.0),
        //     child:ElevatedButton(onPressed: () async{
        //       dynamic result =await _auth.signinAnon(); //dynamic 3shan momkn tb2a null or userinfo returned
        //       if(result == null){
        //         print('User Not Signed In');
        //       }
        //       else{
        //         print('User Signed in successfully');
        //         print(result);
        //       }
        //
        //   }, child: const Text('Sign in anonymous'))
        // )
        Container(
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (val){
                      setState(() {
                        email=val;
                      });
                    },
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    obscureText: true,
                    onChanged: (val){
                      setState(() {
                        password=val;
                      });

                    },
                  ),
                  SizedBox(height: 20.0,),
                  ElevatedButton(onPressed: (){
                    print(email);
                    print(password);
                  }, child: Text('Register'))

                ],
              ),
            )

        )

    );
  }
}
