import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/egg_sale.dart';

class EggSaleProvider extends ChangeNotifier {
  List<EggSale> _eggSales = [];

  List<EggSale> get eggSales => _eggSales;

  // Tambah penjualan telur
  Future<void> addEggSale(EggSale sale) async {
    _eggSales.add(sale);
    notifyListeners();
  }

  // Hapus penjualan telur
  Future<void> deleteEggSale(String saleId) async {
    _eggSales.removeWhere((s) => s.id == saleId);
    notifyListeners();
  }

  // Update penjualan telur
  Future<void> updateEggSale(EggSale sale) async {
    int index = _eggSales.indexWhere((s) => s.id == sale.id);
    if (index != -1) {
      _eggSales[index] = sale;
      notifyListeners();
    }
  }

  // Hitung total penjualan telur
  double getTotalEggSalesRevenue() {
    return _eggSales.fold(0, (sum, sale) => sum + sale.totalPrice);
  }

  // Hitung total telur yang terjual
  int getTotalEggsSold() {
    return _eggSales.fold(0, (sum, sale) => sum + sale.quantity);
  }

  // Harga rata-rata telur
  double getAverageEggPrice() {
    if (_eggSales.isEmpty) return 0;
    return getTotalEggSalesRevenue() / getTotalEggsSold();
  }

  // Dapatkan penjualan dalam rentang tanggal tertentu
  List<EggSale> getSalesByDateRange(DateTime startDate, DateTime endDate) {
    return _eggSales
        .where((s) =>
            s.dateSold.isAfter(startDate) && s.dateSold.isBefore(endDate))
        .toList();
  }

  // Dapatkan total penjualan dalam bulan tertentu
  double getMonthlyRevenue(int month, int year) {
    final sales = _eggSales.where((s) =>
        s.dateSold.month == month && s.dateSold.year == year);
    return sales.fold(0, (sum, sale) => sum + sale.totalPrice);
  }

  // Dapatkan total telur terjual dalam bulan tertentu
  int getMonthlyEggsSold(int month, int year) {
    final sales = _eggSales.where((s) =>
        s.dateSold.month == month && s.dateSold.year == year);
    return sales.fold(0, (sum, sale) => sum + sale.quantity);
  }
}
