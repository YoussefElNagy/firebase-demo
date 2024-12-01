import 'package:flutter/material.dart';
import '../models/workout.dart';
import '../services/firestoreserviceworkout.dart';

class EditWorkoutScreen extends StatefulWidget {
  final String workoutId;

  EditWorkoutScreen({required this.workoutId});

  @override
  State<EditWorkoutScreen> createState() => _EditWorkoutScreenState();
}

class _EditWorkoutScreenState extends State<EditWorkoutScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _exerciseNameController = TextEditingController();
  final TextEditingController _exerciseRepsController = TextEditingController();
  final TextEditingController _exerciseSetsController = TextEditingController();
  final TextEditingController _exerciseRestController = TextEditingController();

  DateTime? _selectedDate; // Date without TextEditingController

  @override
  void initState() {
    super.initState();
    _loadWorkoutDetails();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _exerciseNameController.dispose();
    _exerciseRepsController.dispose();
    _exerciseSetsController.dispose();
    _exerciseRestController.dispose();
    super.dispose();
  }

  void _loadWorkoutDetails() async {
    FirestoreService _firestoreService = FirestoreService();
    Workout? workout = await _firestoreService.readWorkout(widget.workoutId);
    if (workout != null) {
      setState(() {
        _nameController.text = workout.name;
        _exerciseNameController.text = workout.exercise;
        _exerciseRepsController.text = workout.exerciseReps.toString();
        _exerciseSetsController.text = workout.exerciseSets.toString();
        _exerciseRestController.text = workout.exerciseRest.toString();
        _selectedDate = DateTime.tryParse(workout.date as String);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _updateWorkout() async {
    if (formKey.currentState!.validate() && _selectedDate != null) {
      try {
        FirestoreService _firestoreService = FirestoreService();

        final updatedWorkout = Workout(
          id: widget.workoutId,
          name: _nameController.text,
          exercise: _exerciseNameController.text,
          exerciseReps: int.parse(_exerciseRepsController.text),
          exerciseSets: int.parse(_exerciseSetsController.text),
          exerciseRest: int.parse(_exerciseRestController.text),
          date: _selectedDate!, // Convert to String
        );

        await _firestoreService.updateWorkout(widget.workoutId, updatedWorkout);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Workout updated successfully!")),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error updating workout: ${e.toString()}")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields, including the date.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Workout"),
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
                      controller: TextEditingController(
                        text: _selectedDate == null
                            ? ''
                            : "${_selectedDate!.toLocal().toString().split(' ')[0]}",
                      ),
                      validator: (value) =>
                      value == null || value.isEmpty ? 'Please select a date' : null,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(

                  onPressed: _updateWorkout,
                  child: Text("Save Changes"),
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
