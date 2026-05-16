import 'package:cloud_firestore/cloud_firestore.dart';

class FeedRecord {
  final String id;
  final String chickenId;
  final double quantity; // dalam kg
  final DateTime dateRecorded;
  final String feedType; // pakan pagi, siang, malam
  final double cost;
  final String notes;

  FeedRecord({
    required this.id,
    required this.chickenId,
    required this.quantity,
    required this.dateRecorded,
    required this.feedType,
    required this.cost,
    required this.notes,
  });

  // Convert FeedRecord to JSON
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chickenId': chickenId,
      'quantity': quantity,
      'dateRecorded': dateRecorded,
      'feedType': feedType,
      'cost': cost,
      'notes': notes,
    };
  }

  // Convert JSON to FeedRecord object
  factory FeedRecord.fromMap(Map<String, dynamic> map) {
    return FeedRecord(
      id: map['id'] ?? '',
      chickenId: map['chickenId'] ?? '',
      quantity: (map['quantity'] ?? 0.0).toDouble(),
      dateRecorded: (map['dateRecorded'] as Timestamp?)?.toDate() ?? DateTime.now(),
      feedType: map['feedType'] ?? '',
      cost: (map['cost'] ?? 0.0).toDouble(),
      notes: map['notes'] ?? '',
    );
  }

  // CopyWith method
  FeedRecord copyWith({
    String? id,
    String? chickenId,
    double? quantity,
    DateTime? dateRecorded,
    String? feedType,
    double? cost,
    String? notes,
  }) {
    return FeedRecord(
      id: id ?? this.id,
      chickenId: chickenId ?? this.chickenId,
      quantity: quantity ?? this.quantity,
      dateRecorded: dateRecorded ?? this.dateRecorded,
      feedType: feedType ?? this.feedType,
      cost: cost ?? this.cost,
      notes: notes ?? this.notes,
    );
  }
}
