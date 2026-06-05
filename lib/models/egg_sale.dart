import 'package:cloud_firestore/cloud_firestore.dart';

class EggSale {
  final String id;
  final DateTime dateSold;
  final int quantity;
  final double pricePerEgg;
  final double totalPrice;
  final String notes;

  EggSale({
    required this.id,
    required this.dateSold,
    required this.quantity,
    required this.pricePerEgg,
    required this.totalPrice,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateSold': dateSold,
      'quantity': quantity,
      'pricePerEgg': pricePerEgg,
      'totalPrice': totalPrice,
      'notes': notes,
    };
  }

  factory EggSale.fromMap(Map<String, dynamic> map) {
    return EggSale(
      id: map['id'] ?? '',
      dateSold: (map['dateSold'] as Timestamp?)?.toDate() ?? DateTime.now(),
      quantity: map['quantity'] ?? 0,
      pricePerEgg: (map['pricePerEgg'] ?? 0.0).toDouble(),
      totalPrice: (map['totalPrice'] ?? 0.0).toDouble(),
      notes: map['notes'] ?? '',
    );
  }

  EggSale copyWith({
    String? id,
    DateTime? dateSold,
    int? quantity,
    double? pricePerEgg,
    double? totalPrice,
    String? notes,
  }) {
    return EggSale(
      id: id ?? this.id,
      dateSold: dateSold ?? this.dateSold,
      quantity: quantity ?? this.quantity,
      pricePerEgg: pricePerEgg ?? this.pricePerEgg,
      totalPrice: totalPrice ?? this.totalPrice,
      notes: notes ?? this.notes,
    );
  }
}
