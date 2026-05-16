import 'package:cloud_firestore/cloud_firestore.dart';

class EggRecord {
  final String id;
  final String chickenId;
  final DateTime dateRecorded;
  final int quantity;
  final String quality; // normal, small, large, cracked
  final double? weight;
  final String notes;

  EggRecord({
    required this.id,
    required this.chickenId,
    required this.dateRecorded,
    required this.quantity,
    required this.quality,
    this.weight,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chickenId': chickenId,
      'dateRecorded': dateRecorded,
      'quantity': quantity,
      'quality': quality,
      'weight': weight,
      'notes': notes,
    };
  }

  factory EggRecord.fromMap(Map<String, dynamic> map) {
    return EggRecord(
      id: map['id'] ?? '',
      chickenId: map['chickenId'] ?? '',
      dateRecorded: (map['dateRecorded'] as Timestamp?)?.toDate() ?? DateTime.now(),
      quantity: map['quantity'] ?? 0,
      quality: map['quality'] ?? 'normal',
      weight: (map['weight'] ?? 0.0).toDouble(),
      notes: map['notes'] ?? '',
    );
  }

  EggRecord copyWith({
    String? id,
    String? chickenId,
    DateTime? dateRecorded,
    int? quantity,
    String? quality,
    double? weight,
    String? notes,
  }) {
    return EggRecord(
      id: id ?? this.id,
      chickenId: chickenId ?? this.chickenId,
      dateRecorded: dateRecorded ?? this.dateRecorded,
      quantity: quantity ?? this.quantity,
      quality: quality ?? this.quality,
      weight: weight ?? this.weight,
      notes: notes ?? this.notes,
    );
  }
}
