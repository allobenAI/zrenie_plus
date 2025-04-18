class BreakLog {
  final DateTime timestamp;
  final bool completed;
  
  BreakLog({
    required this.timestamp, 
    required this.completed,
  });
  
  // Конвертация из JSON для SharedPreferences
  factory BreakLog.fromJson(Map<String, dynamic> json) {
    return BreakLog(
      timestamp: DateTime.parse(json['timestamp'] as String),
      completed: json['completed'] as bool,
    );
  }
  
  // Конвертация в JSON для SharedPreferences
  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'completed': completed,
    };
  }
}

class StreakData {
  final int currentStreak;
  final int maxStreak;
  final DateTime lastCompleted;
  
  StreakData({
    required this.currentStreak,
    required this.maxStreak,
    required this.lastCompleted,
  });
  
  // Конвертация из JSON для SharedPreferences
  factory StreakData.fromJson(Map<String, dynamic> json) {
    return StreakData(
      currentStreak: json['currentStreak'] as int,
      maxStreak: json['maxStreak'] as int,
      lastCompleted: DateTime.parse(json['lastCompleted'] as String),
    );
  }
  
  // Конвертация в JSON для SharedPreferences
  Map<String, dynamic> toJson() {
    return {
      'currentStreak': currentStreak,
      'maxStreak': maxStreak,
      'lastCompleted': lastCompleted.toIso8601String(),
    };
  }
  
  // Начальные данные
  factory StreakData.initial() {
    return StreakData(
      currentStreak: 0,
      maxStreak: 0,
      lastCompleted: DateTime(2000), // Старая дата для начала
    );
  }
} 