import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/egg_record.dart';
import '../models/feed_record.dart';
import '../models/health_record.dart';

class RecordProvider extends ChangeNotifier {
  List<EggRecord> _eggRecords = [];
  List<FeedRecord> _feedRecords = [];
  List<HealthRecord> _healthRecords = [];

  List<EggRecord> get eggRecords => _eggRecords;
  List<FeedRecord> get feedRecords => _feedRecords;
  List<HealthRecord> get healthRecords => _healthRecords;

  // ===== EGG RECORD OPERATIONS =====
  Future<void> addEggRecord(EggRecord record) async {
    _eggRecords.add(record);
    notifyListeners();
  }

  Future<void> deleteEggRecord(String recordId) async {
    _eggRecords.removeWhere((r) => r.id == recordId);
    notifyListeners();
  }

  Future<void> updateEggRecord(EggRecord record) async {
    int index = _eggRecords.indexWhere((r) => r.id == record.id);
    if (index != -1) {
      _eggRecords[index] = record;
      notifyListeners();
    }
  }

  List<EggRecord> getEggRecordsByChickenId(String chickenId) {
    return _eggRecords.where((r) => r.chickenId == chickenId).toList();
  }

  // ===== FEED RECORD OPERATIONS =====
  Future<void> addFeedRecord(FeedRecord record) async {
    _feedRecords.add(record);
    notifyListeners();
  }

  Future<void> deleteFeedRecord(String recordId) async {
    _feedRecords.removeWhere((r) => r.id == recordId);
    notifyListeners();
  }

  Future<void> updateFeedRecord(FeedRecord record) async {
    int index = _feedRecords.indexWhere((r) => r.id == record.id);
    if (index != -1) {
      _feedRecords[index] = record;
      notifyListeners();
    }
  }

  List<FeedRecord> getFeedRecordsByChickenId(String chickenId) {
    return _feedRecords.where((r) => r.chickenId == chickenId).toList();
  }

  // ===== HEALTH RECORD OPERATIONS =====
  Future<void> addHealthRecord(HealthRecord record) async {
    _healthRecords.add(record);
    notifyListeners();
  }

  Future<void> deleteHealthRecord(String recordId) async {
    _healthRecords.removeWhere((r) => r.id == recordId);
    notifyListeners();
  }

  Future<void> updateHealthRecord(HealthRecord record) async {
    int index = _healthRecords.indexWhere((r) => r.id == record.id);
    if (index != -1) {
      _healthRecords[index] = record;
      notifyListeners();
    }
  }

  List<HealthRecord> getHealthRecordsByChickenId(String chickenId) {
    return _healthRecords.where((r) => r.chickenId == chickenId).toList();
  }
}
