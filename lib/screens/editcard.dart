import 'package:firebase/models/model.dart';
import 'package:flutter/material.dart';
import '../services/firestoreservice.dart';

class EditCardScreen extends StatefulWidget {
  final String cardId; // Use cardId instead of userId to reference the card

  EditCardScreen({required this.cardId});

  @override
  State<EditCardScreen> createState() => _EditCardScreenState();
}

class _EditCardScreenState extends State<EditCardScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCardDetails();
  }

  void _loadCardDetails() async {
    FirestoreService _firestoreService = FirestoreService();
    BusinessCard? card = await _firestoreService.readObj(widget.cardId);

    if (card != null) {
      _nameController.text = card.name;
      _jobTitleController.text = card.jobTitle;
      _companyController.text = card.company;
      _emailController.text = card.email;
      _phoneController.text = card.phone;
    }
  }

  void _updateCard() async {
    if (formKey.currentState!.validate()) {
      try {
        FirestoreService _firestoreService = FirestoreService();

        // Create the updated card object with the existing card ID
        final updatedCard = BusinessCard(
          id: widget.cardId, // Use the card ID passed to the screen
          name: _nameController.text,
          jobTitle: _jobTitleController.text,
          company: _companyController.text,
          email: _emailController.text,
          phone: _phoneController.text,
        );

        // Update the card in Firestore
        await _firestoreService.updateObj(widget.cardId, updatedCard);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Card updated successfully!")),
        );

        // Navigate back to the previous screen after successful update
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error updating card: ${e.toString()}")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(
                "Edit Card",
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(height: 10),
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
                      validator: (value) => value == null || value.isEmpty
                          ? "Please enter a name"
                          : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _jobTitleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? "Please enter a job title"
                          : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _companyController,
                      decoration: InputDecoration(
                        labelText: 'Company',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? "Please enter a company"
                          : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => value == null || value.isEmpty
                          ? "Please enter an email"
                          : null,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) => value == null || value.isEmpty
                          ? "Please enter a phone number"
                          : null,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _updateCard,
                      child: Text("Save Changes"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
