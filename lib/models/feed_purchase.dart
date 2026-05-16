import 'package:cloud_firestore/cloud_firestore.dart';

class FeedPurchase {
  final String id;
  final String feedType; // pakan pagi, pakan siang, pakan malam
  final DateTime datePurchased;
  final double quantity; // kg
  final double pricePerKg;
  final double totalCost;
  final String supplier;
  final String notes;

  FeedPurchase({
    required this.id,
    required this.feedType,
    required this.datePurchased,
    required this.quantity,
    required this.pricePerKg,
    required this.totalCost,
    required this.supplier,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'feedType': feedType,
      'datePurchased': datePurchased,
      'quantity': quantity,
      'pricePerKg': pricePerKg,
      'totalCost': totalCost,
      'supplier': supplier,
      'notes': notes,
    };
  }

  factory FeedPurchase.fromMap(Map<String, dynamic> map) {
    return FeedPurchase(
      id: map['id'] ?? '',
      feedType: map['feedType'] ?? '',
      datePurchased: (map['datePurchased'] as Timestamp?)?.toDate() ?? DateTime.now(),
      quantity: (map['quantity'] ?? 0.0).toDouble(),
      pricePerKg: (map['pricePerKg'] ?? 0.0).toDouble(),
      totalCost: (map['totalCost'] ?? 0.0).toDouble(),
      supplier: map['supplier'] ?? '',
      notes: map['notes'] ?? '',
    );
  }

  FeedPurchase copyWith({
    String? id,
    String? feedType,
    DateTime? datePurchased,
    double? quantity,
    double? pricePerKg,
    double? totalCost,
    String? supplier,
    String? notes,
  }) {
    return FeedPurchase(
      id: id ?? this.id,
      feedType: feedType ?? this.feedType,
      datePurchased: datePurchased ?? this.datePurchased,
      quantity: quantity ?? this.quantity,
      pricePerKg: pricePerKg ?? this.pricePerKg,
      totalCost: totalCost ?? this.totalCost,
      supplier: supplier ?? this.supplier,
      notes: notes ?? this.notes,
    );
  }
}
