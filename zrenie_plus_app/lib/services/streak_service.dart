import '../models/break_log.dart';
import 'storage_service.dart';

class StreakService {
  final StorageService _storageService;
  
  StreakService(this._storageService);
  
  // Обновление серии после выполнения/пропуска перерыва
  Future<StreakData> updateStreak(bool completed) async {
    final StreakData currentData = _storageService.getStreakData();
    late StreakData newData;
    
    if (completed) {
      // Если это первый перерыв или последний был сегодня - увеличиваем серию
      final bool isToday = _isToday(currentData.lastCompleted);
      
      if (isToday) {
        // Уже было сегодня, просто обновляем время последнего выполнения
        newData = StreakData(
          currentStreak: currentData.currentStreak,
          maxStreak: currentData.maxStreak,
          lastCompleted: DateTime.now(),
        );
      } else {
        // Новый день - увеличиваем серию
        final int newStreak = currentData.currentStreak + 1;
        final int newMaxStreak = newStreak > currentData.maxStreak 
            ? newStreak 
            : currentData.maxStreak;
            
        newData = StreakData(
          currentStreak: newStreak,
          maxStreak: newMaxStreak,
          lastCompleted: DateTime.now(),
        );
      }
    } else {
      // Перерыв пропущен - сбрасываем текущую серию
      newData = StreakData(
        currentStreak: 0,
        maxStreak: currentData.maxStreak,
        lastCompleted: currentData.lastCompleted,
      );
    }
    
    // Сохраняем обновленные данные
    await _storageService.saveStreakData(newData);
    return newData;
  }
  
  // Проверка, была ли дата сегодня
  bool _isToday(DateTime date) {
    final DateTime now = DateTime.now();
    return date.year == now.year && 
           date.month == now.month && 
           date.day == now.day;
  }
  
  // Получить текущие данные о серии
  StreakData getCurrentStreak() {
    return _storageService.getStreakData();
  }
} 