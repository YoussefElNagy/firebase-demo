import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionRef = 'business_cards'; // Changed variable name for clarity

  // Get all BusinessCards from the collection and include document IDs
  Future<List<BusinessCard>> getAllCards() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection(_collectionRef).get();
      return snapshot.docs.map((doc) {
        return BusinessCard.fromMap(doc.data() as Map<String, dynamic>, doc.id); // Pass doc.id
      }).toList();
    } catch (e) {
      print("Error fetching all cards: $e");
      return [];
    }
  }

  String generateDocId() {
    return _firestore.collection(_collectionRef).doc().id;
  }
  // Save a BusinessCard to Firestore
  Future<void> setObj(String cardId, BusinessCard card) async {
    try {
      await _firestore.collection(_collectionRef).doc(cardId).set(card.toMap());
    } catch (e) {
      print("Error saving card: $e");
      rethrow;
    }
  }

  Future<void> addObj(BusinessCard card) async {
    try {
      await _firestore.collection(_collectionRef).add(card.toMap());
    } catch (e) {
      print("Error adding card: $e");
      rethrow;
    }
  }

  // Fetch a BusinessCard by its document ID
  Future<BusinessCard?> readObj(String cardId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection(_collectionRef).doc(cardId).get();
      if (!doc.exists) return null;
      return BusinessCard.fromMap(doc.data() as Map<String, dynamic>, doc.id); // Include doc.id
    } catch (e) {
      print("Error fetching card: $e");
      return null;
    }
  }

  // Update a BusinessCard by its document ID
  Future<void> updateObj(String cardId, BusinessCard card) async {
    try {
      await _firestore.collection(_collectionRef).doc(cardId).update(card.toMap());
    } catch (e) {
      print("Error updating card: $e");
      rethrow;
    }
  }

  // Delete a BusinessCard by its document ID
  Future<void> deleteObj(String cardId) async {
    try {
      await _firestore.collection(_collectionRef).doc(cardId).delete();
    } catch (e) {
      print("Error deleting card: $e");
      rethrow;
    }
  }

  // Get raw Map data for a specific document
  Future<Map<String, dynamic>?> getObj(String cardId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection(_collectionRef).doc(cardId).get();
      return doc.exists ? doc.data() as Map<String, dynamic>? : null;
    } catch (e) {
      print("Error fetching object: $e");
      return null;
    }
  }
}
