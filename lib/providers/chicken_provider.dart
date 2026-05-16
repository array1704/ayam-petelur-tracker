import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/chicken.dart';
import '../providers/chicken_provider.dart';

class ChickenProvider extends ChangeNotifier {
  List<Chicken> _chickens = [];
  Chicken? _selectedChicken;

  List<Chicken> get chickens => _chickens;
  Chicken? get selectedChicken => _selectedChicken;

  // Tambah ayam baru
  Future<void> addChicken(Chicken chicken) async {
    _chickens.add(chicken);
    notifyListeners();
  }

  // Hapus ayam
  Future<void> deleteChicken(String chickenId) async {
    _chickens.removeWhere((c) => c.id == chickenId);
    notifyListeners();
  }

  // Update ayam
  Future<void> updateChicken(Chicken chicken) async {
    int index = _chickens.indexWhere((c) => c.id == chicken.id);
    if (index != -1) {
      _chickens[index] = chicken;
      notifyListeners();
    }
  }

  // Pilih ayam
  void selectChicken(Chicken chicken) {
    _selectedChicken = chicken;
    notifyListeners();
  }

  // Dapatkan ayam berdasarkan ID
  Chicken? getChickenById(String id) {
    try {
      return _chickens.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }
}
