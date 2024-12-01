import 'package:cloud_firestore/cloud_firestore.dart';

class BusinessCard {
  final String company;
  final String email;
  final String jobTitle;
  final String name;
  final String phone;
  final String id;

  BusinessCard({
    required this.id,  // add id
    required this.company,
    required this.email,
    required this.jobTitle,
    required this.name,
    required this.phone,
  });

  // Convert a Model object to a Map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'company': company,
      'email': email,
      'jobTitle': jobTitle,
      'name': name,
      'phone': phone,
    };
  }

  // Create a Model object from a Firestore document snapshot
  factory BusinessCard.fromMap(Map<String, dynamic> map, String id) {
    return BusinessCard(
      id: id,  // add id mapping
      name: map['name'] ?? '',
      jobTitle: map['jobTitle'] ?? '',
      company: map['company'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
    );
  }


}
