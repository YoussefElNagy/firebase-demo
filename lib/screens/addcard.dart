import 'package:firebase/models/model.dart';
import 'package:firebase/screens/ViewCards.dart';
import 'package:firebase/services/firestoreservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddCardScreen extends StatefulWidget {
  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  final _nameController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _companyController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  void _saveDate() async {
    if (formKey.currentState!.validate()) {
      try {
        FirestoreService _firestoreService = FirestoreService();

        // Generate a new document ID using Firestore
        String newDocId =
            _firestoreService.generateDocId(); // Assume this method exists

        final addedCard = BusinessCard(
          id: newDocId, // Ensure id is set here
          name: _nameController.text,
          jobTitle: _jobTitleController.text,
          company: _companyController.text,
          email: _emailController.text,
          phone: _phoneController.text,
        );

        await _firestoreService.addObj(addedCard);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Card added successfully!")),
        );

        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const ViewCards()),
        // );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error saving card: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Text(
              "Add a new card ",
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
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
                      controller: _jobTitleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
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
                      controller: _companyController,
                      decoration: InputDecoration(
                        labelText: 'Company',
                        border: OutlineInputBorder(),
                      ),
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
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
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
                    ElevatedButton(
                        onPressed: () {
                          _saveDate();
                        },
                        child: Text("Add Card"))
                  ],
                )),
          )
        ],
      ),
    );
  }
}
