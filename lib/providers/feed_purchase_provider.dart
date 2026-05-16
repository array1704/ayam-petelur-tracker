import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/feed_purchase.dart';

class FeedPurchaseProvider extends ChangeNotifier {
  List<FeedPurchase> _feedPurchases = [];

  List<FeedPurchase> get feedPurchases => _feedPurchases;

  // Tambah pembelian pakan
  Future<void> addFeedPurchase(FeedPurchase purchase) async {
    _feedPurchases.add(purchase);
    notifyListeners();
  }

  // Hapus pembelian pakan
  Future<void> deleteFeedPurchase(String purchaseId) async {
    _feedPurchases.removeWhere((p) => p.id == purchaseId);
    notifyListeners();
  }

  // Update pembelian pakan
  Future<void> updateFeedPurchase(FeedPurchase purchase) async {
    int index = _feedPurchases.indexWhere((p) => p.id == purchase.id);
    if (index != -1) {
      _feedPurchases[index] = purchase;
      notifyListeners();
    }
  }

  // Hitung total biaya semua pembelian
  double getTotalCost() {
    return _feedPurchases.fold(0, (sum, p) => sum + p.totalCost);
  }

  // Hitung total kuantitas pakan
  double getTotalQuantity() {
    return _feedPurchases.fold(0, (sum, p) => sum + p.quantity);
  }

  // Dapatkan pembelian dalam rentang tanggal tertentu
  List<FeedPurchase> getPurchasesByDateRange(DateTime startDate, DateTime endDate) {
    return _feedPurchases
        .where((p) =>
            p.datePurchased.isAfter(startDate) && p.datePurchased.isBefore(endDate))
        .toList();
  }

  // Dapatkan pembelian berdasarkan jenis pakan
  List<FeedPurchase> getPurchasesByFeedType(String feedType) {
    return _feedPurchases.where((p) => p.feedType == feedType).toList();
  }

  // Hitung rata-rata harga per kg
  double getAveragePricePerKg() {
    if (_feedPurchases.isEmpty) return 0;
    double totalPrice = _feedPurchases.fold(0, (sum, p) => sum + (p.pricePerKg * p.quantity));
    double totalQty = getTotalQuantity();
    return totalQty > 0 ? totalPrice / totalQty : 0;
  }
}
