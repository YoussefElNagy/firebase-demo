import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/workout.dart';
import '../services/firestoreserviceworkout.dart';

class AddWorkoutScreen extends StatefulWidget {
  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _exerciseNameController = TextEditingController();
  final TextEditingController _exerciseRepsController = TextEditingController();
  final TextEditingController _exerciseSetsController = TextEditingController();
  final TextEditingController _exerciseRestController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  DateTime? _selectedDate;

  @override
  void dispose() {
    _nameController.dispose();
    _exerciseNameController.dispose();
    _exerciseRepsController.dispose();
    _exerciseSetsController.dispose();
    _exerciseRestController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _addWorkout() async {
    if (formKey.currentState!.validate()) {
      try {
        FirestoreService _firestoreService = FirestoreService();

        // Parse the numeric inputs to ensure they are valid integers
        int? reps = int.tryParse(_exerciseRepsController.text);
        int? sets = int.tryParse(_exerciseSetsController.text);
        int? rest = int.tryParse(_exerciseRestController.text);

        // Validate that reps, sets, and rest are valid integers
        if (reps == null || reps <= 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please enter a valid number for reps")),
          );
          return;
        }
        if (sets == null || sets <= 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please enter a valid number for sets")),
          );
          return;
        }
        if (rest == null || rest <= 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please enter a valid rest time")),
          );
          return;
        }

        // Validate that a date is selected
        if (_selectedDate == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please select a date")),
          );
          return;
        }

        // Firestore timestamp conversion
        Timestamp firestoreTimestamp = Timestamp.fromDate(_selectedDate!);

        String newDocId = _firestoreService.generateDocId();

        final addedWorkout = Workout(
          id: newDocId,
          name: _nameController.text,
          exercise: _exerciseNameController.text,
          exerciseReps: reps,
          exerciseRest: rest,
          exerciseSets: sets,
          date: firestoreTimestamp.toDate(),
        );

        await _firestoreService.addWorkout(addedWorkout);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Workout added successfully!")),
        );

        // Clear input fields after success
        _nameController.clear();
        _exerciseNameController.clear();
        _exerciseRepsController.clear();
        _exerciseSetsController.clear();
        _exerciseRestController.clear();
        _dateController.clear();

        } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error saving data: $e")),
        );
      }
    }
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        // Format the date as 'yyyy-MM-dd' and update the controller
        _dateController.text = "${_selectedDate!.toLocal().toIso8601String().split('T')[0]}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Workout",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Workout Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "Please enter a workout name"
                      : null,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _exerciseNameController,
                  decoration: InputDecoration(
                    labelText: 'Exercise Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "Please enter an exercise name"
                      : null,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _exerciseRepsController,
                  decoration: InputDecoration(
                    labelText: 'Repetitions',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty
                      ? "Please enter the number of reps"
                      : null,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _exerciseSetsController,
                  decoration: InputDecoration(
                    labelText: 'Sets',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty
                      ? "Please enter the number of sets"
                      : null,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _exerciseRestController,
                  decoration: InputDecoration(
                    labelText: 'Rest (in seconds)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty
                      ? "Please enter the rest time"
                      : null,
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Date',
                        border: OutlineInputBorder(),
                      ),
                      controller: _dateController,
                      validator: (value) =>
                      value == null || value.isEmpty ? 'Please select a date' : null,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addWorkout,
                  child: Text("Add workout",style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor,fontSize: 20),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
