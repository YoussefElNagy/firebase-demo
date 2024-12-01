import 'package:firebase/services/firestoreserviceworkout.dart';
import 'package:flutter/material.dart';
import '../models/workout.dart';
import 'editWorkout.dart';

class ViewWorkouts extends StatefulWidget {
  const ViewWorkouts({super.key});

  @override
  State<ViewWorkouts> createState() => _ViewWorkoutsState();
}

class _ViewWorkoutsState extends State<ViewWorkouts> {
  final FirestoreService _firestoreService = FirestoreService();
  List<Workout> _filteredWorkouts = [];
  List<Workout> _allWorkouts = [];  // To store all workouts before applying filters
  String _sortBy = 'date';  // Default sorting by date
  bool _isAscending = true;  // Sorting order
  String _filterText = '';  // Text for filtering by workout/exercise name

  @override
  void initState() {
    super.initState();
    _fetchWorkouts();
  }

  // Fetch workouts from Firestore
  Future<void> _fetchWorkouts() async {
    try {
      final workouts = await _firestoreService.getAllWorkouts();
      setState(() {
        _allWorkouts = workouts;
        _filteredWorkouts = workouts;
      });
    } catch (e) {
      print("Error fetching workouts: $e");
    }
  }

  // Sort workouts based on the selected criteria
  void _sortWorkouts() {
    setState(() {
      _filteredWorkouts.sort((a, b) {
        int result = 0;
        switch (_sortBy) {
          case 'exerciseSets':
            result = a.exerciseSets.compareTo(b.exerciseSets);
            break;
          case 'exerciseReps':
            result = a.exerciseReps.compareTo(b.exerciseReps);
            break;
          case 'date':
            result = a.date.compareTo(b.date);
            break;
        }
        return _isAscending ? result : -result;
      });
    });
  }

  // Filter workouts based on the filter text
  void _filterWorkouts() {
    setState(() {
      _filteredWorkouts = _allWorkouts.where((workout) {
        return workout.name.toLowerCase().contains(_filterText.toLowerCase()) ||
            workout.exercise.toLowerCase().contains(_filterText.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("View Workouts"),
      //   centerTitle: true,
      // ),
      body: Column(
        children: [
          Text("Workouts",style: TextStyle(color: Color(0xFF4ecdc4),fontSize: 30,fontWeight: FontWeight.bold),),
          SizedBox(height: 20),
          // Sorting and filtering options
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Filter TextField inside an Expanded widget to take up remaining space
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _filterText = value;
                      });
                      _filterWorkouts(); // Apply the filter
                    },
                    decoration: InputDecoration(
                      labelText: 'Filter by workout/exercise name',
                      labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                      filled: true,
                      fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                      border: Theme.of(context).inputDecorationTheme.border,
                      focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
                      enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
                      floatingLabelStyle: Theme.of(context).inputDecorationTheme.floatingLabelStyle,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // DropdownButton for sorting options with custom theme
                DropdownButton<String>(
                  value: _sortBy,
                  onChanged: (String? newValue) {
                    setState(() {
                      _sortBy = newValue!;
                    });
                    _sortWorkouts(); // Sort the workouts based on new value
                  },
                  style: TextStyle(color: Theme.of(context).colorScheme.primary), // Dropdown text color from theme
                  iconEnabledColor: Theme.of(context).colorScheme.primary, // Dropdown icon color from theme
                  items: const [
                    DropdownMenuItem(value: 'date', child: Text('Sort by Date')),
                    DropdownMenuItem(value: 'exerciseSets', child: Text('Sort by Sets')),
                    DropdownMenuItem(value: 'exerciseReps', child: Text('Sort by Reps')),
                  ],
                  underline: Container(
                    height: 2,
                    color: Theme.of(context).colorScheme.primary, // Underline color from theme
                  ),
                ),
                const SizedBox(width: 8),
                // IconButton to toggle sorting order with custom color from theme
                IconButton(
                  icon: Icon(
                    _isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                    color: Theme.of(context).colorScheme.primary, // Icon color from theme
                  ),
                  onPressed: () {
                    setState(() {
                      _isAscending = !_isAscending;
                    });
                    _sortWorkouts(); // Apply sorting order change
                  },
                ),
              ],
            ),
          ),


          Expanded(
            child: _filteredWorkouts.isEmpty
                ? const Center(child: Text("No workouts available."))
                : ListView.builder(
              itemCount: _filteredWorkouts.length,
              itemBuilder: (context, index) {
                final workout = _filteredWorkouts[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                  color: Theme.of(context).colorScheme.tertiary,
                  elevation: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).colorScheme.primary, width: 3),
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    child: ListTile(
                      title: Center(
                        child: Text(
                          workout.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Exercise: ${workout.exercise}'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${workout.exerciseSets} x ${workout.exerciseReps} ',
                                ),
                                Text('Rest: ${workout.exerciseRest} seconds'),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(workout.date.toString())
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditWorkoutScreen(workoutId: workout.id),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
