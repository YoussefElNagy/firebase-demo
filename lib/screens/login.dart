import 'package:firebase/screens/home.dart';
import 'package:firebase/screens/signup.dart';
import 'package:firebase/services/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        throw FirebaseAuthException(
          code: 'empty-fields',
          message: 'Please fill in all fields.',
        );
      }

      final auth = FirebaseAuthService();
      // Attempt to sign in the user
      var user = await auth.signIn(email, password);
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'User not found in Firestore.',
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      print(e.code);
      switch (e.code) {
        case 'invalid-credential':
          errorMessage = 'Incorrect email or password.';
          break;
        case 'invalid-email':
          errorMessage = 'Enter a valid email!';
          break;
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unexpected error occurred: $e'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome, please login!",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 50),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          validator: (x) {
                            if (x == null || x.isEmpty) {
                              return "Fill empty Field(s)";
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder()),
                          obscureText: true,
                          autocorrect: false,
                          validator: (x) {
                            if (x == null || x.isEmpty) {
                              return "Fill empty Field(s)";
                            }
                          },
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        _isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primary, // Directly set the color
                                ),
                                onPressed: _isLoading
                                    ? null
                                    : () {
                                        if (formKey.currentState!.validate()) {
                                          _login();
                                        }
                                      },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary, // Text color matching button background
                                  ),
                                ),
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Don't have an account?"),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SignUpScreen()));
                                },
                                child: Text("Sign up!"))
                          ],
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
