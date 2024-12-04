import'package:flutter/material.dart';
import 'package:firebase/JulScreens/Services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  String email='';
  String password= '';
  final AuthService _auth = AuthService();  //instance mn class AuthService 3shan a-use el services of class whether anonymous or email/password
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title: const Text('Sign in to Brew Crew'),
          backgroundColor: Colors.brown[400],
          actions: [
            TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              icon: const Icon(Icons.person, color: Colors.white),
              label: const Text(
                'Register',
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
                  }, child: Text('SignIn'))

                ],
              ),
            )

        )

    );
  }
}
