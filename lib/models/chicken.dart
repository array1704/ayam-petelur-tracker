import 'package:cloud_firestore/cloud_firestore.dart';

class Chicken {
  final String id;
  final String name;
  final String breed;
  final DateTime dateAdded;
  final String color;
  final String status; // active, sick, sold, dead
  final double currentWeight;
  final int eggCount;
  final String notes;

  Chicken({
    required this.id,
    required this.name,
    required this.breed,
    required this.dateAdded,
    required this.color,
    required this.status,
    required this.currentWeight,
    required this.eggCount,
    required this.notes,
  });

  // Convert Chicken to JSON (untuk Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'breed': breed,
      'dateAdded': dateAdded,
      'color': color,
      'status': status,
      'currentWeight': currentWeight,
      'eggCount': eggCount,
      'notes': notes,
    };
  }

  // Convert JSON ke Chicken object
  factory Chicken.fromMap(Map<String, dynamic> map) {
    return Chicken(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      breed: map['breed'] ?? '',
      dateAdded: (map['dateAdded'] as Timestamp?)?.toDate() ?? DateTime.now(),
      color: map['color'] ?? '',
      status: map['status'] ?? 'active',
      currentWeight: (map['currentWeight'] ?? 0.0).toDouble(),
      eggCount: map['eggCount'] ?? 0,
      notes: map['notes'] ?? '',
    );
  }

  // CopyWith method untuk update data
  Chicken copyWith({
    String? id,
    String? name,
    String? breed,
    DateTime? dateAdded,
    String? color,
    String? status,
    double? currentWeight,
    int? eggCount,
    String? notes,
  }) {
    return Chicken(
      id: id ?? this.id,
      name: name ?? this.name,
      breed: breed ?? this.breed,
      dateAdded: dateAdded ?? this.dateAdded,
      color: color ?? this.color,
      status: status ?? this.status,
      currentWeight: currentWeight ?? this.currentWeight,
      eggCount: eggCount ?? this.eggCount,
      notes: notes ?? this.notes,
    );
  }
}
