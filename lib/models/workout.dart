import 'package:cloud_firestore/cloud_firestore.dart';

class Workout {
  final String id; // Unique identifier for the workout
  final String name; // Workout type (e.g., "Push")
  final String exercise; // Exercise name (e.g., "Bench Press")
  final int exerciseReps; // Number of reps (e.g., 10)
  final int exerciseRest; // Rest duration in minutes (e.g., 2)
  final int exerciseSets; // Number of sets (e.g., 4)
  final DateTime date; // Timestamp for the workout

  Workout({
    required this.id,
    required this.name,
    required this.exercise,
    required this.exerciseReps,
    required this.exerciseRest,
    required this.exerciseSets,
    required this.date,
  });

  // Convert a Workout object to a Map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'exercise': exercise,
      'exerciseReps': exerciseReps,
      'exerciseRest': exerciseRest,
      'exerciseSets': exerciseSets,
      'date': date.toIso8601String(), // Store date as ISO 8601 string
    };
  }

  // Create a Workout object from a Firestore document snapshot
  factory Workout.fromMap(Map<String, dynamic> map, String id) {
    return Workout(
      id: id,
      name: map['name'] ?? '',
      exercise: map['exercise'] ?? '',
      exerciseReps: map['exerciseReps'] ?? 0,
      exerciseRest: map['exerciseRest'] ?? 0,
      exerciseSets: map['exerciseSets'] ?? 0,
      date: map['date'] is Timestamp
          ? (map['date'] as Timestamp).toDate() // Convert Firestore Timestamp to DateTime
          : DateTime.now(), // Fallback in case it's not a Timestamp
    );
  }
}
