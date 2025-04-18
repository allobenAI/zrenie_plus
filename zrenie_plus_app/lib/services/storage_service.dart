// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
import '../models/break_log.dart';
import '../utils/constants.dart';

/// Временная заглушка для StorageService
/// Не использует shared_preferences из-за проблем с совместимостью Android SDK
class StorageService {
  // Временное хранилище данных в памяти
  final Map<String, dynamic> _memoryStorage = {};
  
  // Инициализация
  Future<void> init() async {
    // Заглушка - никаких внешних зависимостей
    print('Storage service initialized in memory (временная заглушка)');
  }
  
  // Получение настроек пользователя
  Map<String, dynamic> getSettings() {
    // Возвращаем дефолтные настройки или сохраненные в памяти
    return _memoryStorage[AppConstants.settingsKey] as Map<String, dynamic>? ?? {
      'workMinutes': AppConstants.defaultWorkMinutes,
      'isDarkMode': false,
      'notificationsEnabled': true,
      'soundEnabled': true,
      'vibrationEnabled': true,
    };
  }
  
  // Сохранение настроек пользователя
  Future<bool> saveSettings(Map<String, dynamic> settings) async {
    _memoryStorage[AppConstants.settingsKey] = settings;
    return true;
  }
  
  // Получение данных о серии выполненных перерывов
  StreakData getStreakData() {
    return _memoryStorage[AppConstants.streakKey] as StreakData? ?? StreakData.initial();
  }
  
  // Сохранение данных о серии
  Future<bool> saveStreakData(StreakData data) async {
    _memoryStorage[AppConstants.streakKey] = data;
    return true;
  }
  
  // Получение списка логов перерывов
  List<BreakLog> getBreakLogs() {
    return _memoryStorage[AppConstants.statsKey] as List<BreakLog>? ?? [];
  }
  
  // Добавление нового лога перерыва
  Future<bool> addBreakLog(BreakLog log) async {
    final List<BreakLog> logs = getBreakLogs();
    logs.add(log);
    
    // Сохраняем только последние 100 записей для экономии места
    if (logs.length > 100) {
      logs.removeAt(0);
    }
    
    _memoryStorage[AppConstants.statsKey] = logs;
    return true;
  }
  
  // Очистка всех данных
  Future<bool> clearAllData() async {
    _memoryStorage.clear();
    return true;
  }
} 