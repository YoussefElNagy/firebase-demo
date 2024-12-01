import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/workout.dart'; // Import your updated Workout model

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionRef = 'workouts'; // Updated collection name

  // Get all Workouts from the collection and include document IDs
  Future<List<Workout>> getAllWorkouts() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('workouts').get();
      print("Fetched ${snapshot.docs.length} workouts");

      return snapshot.docs.map((doc) {
        return Workout.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print("Error fetching all workouts: $e");
      return [];
    }
  }


  // Generate a unique document ID
  String generateDocId() {
    return _firestore.collection(_collectionRef).doc().id;
  }

  // Save a Workout to Firestore using a specific document ID
  Future<void> setWorkout(String workoutId, Workout workout) async {
    try {
      await _firestore.collection(_collectionRef).doc(workoutId).set(workout.toMap());
    } catch (e) {
      print("Error saving workout: $e");
      rethrow;
    }
  }

  // Add a new Workout to Firestore (auto-generate document ID)
  Future<void> addWorkout(Workout workout) async {
    try {
      await _firestore.collection(_collectionRef).add(workout.toMap());
    } catch (e) {
      print("Error adding workout: $e");
      rethrow;
    }
  }

  // Fetch a Workout by its document ID
  Future<Workout?> readWorkout(String workoutId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection(_collectionRef).doc(workoutId).get();
      if (!doc.exists) return null;
      return Workout.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    } catch (e) {
      print("Error fetching workout: $e");
      return null;
    }
  }

  // Update a Workout by its document ID
  Future<void> updateWorkout(String workoutId, Workout workout) async {
    try {
      await _firestore.collection(_collectionRef).doc(workoutId).update(workout.toMap());
    } catch (e) {
      print("Error updating workout: $e");
      rethrow;
    }
  }

  // Delete a Workout by its document ID
  Future<void> deleteWorkout(String workoutId) async {
    try {
      await _firestore.collection(_collectionRef).doc(workoutId).delete();
    } catch (e) {
      print("Error deleting workout: $e");
      rethrow;
    }
  }

  // Get raw Map data for a specific document
  Future<Map<String, dynamic>?> getWorkout(String workoutId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection(_collectionRef).doc(workoutId).get();
      return doc.exists ? doc.data() as Map<String, dynamic>? : null;
    } catch (e) {
      print("Error fetching workout object: $e");
      return null;
    }
  }
}
