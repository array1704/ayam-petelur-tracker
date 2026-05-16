import 'package:cloud_firestore/cloud_firestore.dart';

class HealthRecord {
  final String id;
  final String chickenId;
  final DateTime dateRecorded;
  final String healthStatus; // healthy, sick, recovering
  final String? disease;
  final String? treatment;
  final double? temperature;
  final String notes;

  HealthRecord({
    required this.id,
    required this.chickenId,
    required this.dateRecorded,
    required this.healthStatus,
    this.disease,
    this.treatment,
    this.temperature,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chickenId': chickenId,
      'dateRecorded': dateRecorded,
      'healthStatus': healthStatus,
      'disease': disease,
      'treatment': treatment,
      'temperature': temperature,
      'notes': notes,
    };
  }

  factory HealthRecord.fromMap(Map<String, dynamic> map) {
    return HealthRecord(
      id: map['id'] ?? '',
      chickenId: map['chickenId'] ?? '',
      dateRecorded: (map['dateRecorded'] as Timestamp?)?.toDate() ?? DateTime.now(),
      healthStatus: map['healthStatus'] ?? 'healthy',
      disease: map['disease'],
      treatment: map['treatment'],
      temperature: (map['temperature'] ?? 0.0).toDouble(),
      notes: map['notes'] ?? '',
    );
  }

  HealthRecord copyWith({
    String? id,
    String? chickenId,
    DateTime? dateRecorded,
    String? healthStatus,
    String? disease,
    String? treatment,
    double? temperature,
    String? notes,
  }) {
    return HealthRecord(
      id: id ?? this.id,
      chickenId: chickenId ?? this.chickenId,
      dateRecorded: dateRecorded ?? this.dateRecorded,
      healthStatus: healthStatus ?? this.healthStatus,
      disease: disease ?? this.disease,
      treatment: treatment ?? this.treatment,
      temperature: temperature ?? this.temperature,
      notes: notes ?? this.notes,
    );
  }
}
