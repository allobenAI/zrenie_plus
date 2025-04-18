class AppConstants {
  // Таймеры
  static const int defaultWorkMinutes = 20; // Время работы по умолчанию (20 минут)
  static const int defaultBreakSeconds = 20; // Время перерыва по умолчанию (20 секунд)
  static const int minimumWorkMinutes = 5; // Минимальное время работы
  static const int maximumWorkMinutes = 60; // Максимальное время работы
  
  // Уведомления
  static const String notificationChannelId = 'zrenie_plus_notifications';
  static const String notificationChannelName = 'Уведомления Зрение+';
  static const String notificationChannelDescription = 'Уведомления о перерывах для глаз';
  static const int notificationId = 1;
  
  // Хранилище данных
  static const String settingsKey = 'app_settings';
  static const String streakKey = 'user_streak';
  static const String statsKey = 'user_stats';
  
  // Тексты
  static const String appName = 'Зрение+';
  static const String homeScreenTitle = 'Главная';
  static const String breakScreenTitle = 'Перерыв';
  static const String statsScreenTitle = 'Статистика';
  static const String settingsScreenTitle = 'Настройки';
  
  // Сообщения
  static const String breakTimeMessage = 'Пора сделать перерыв для глаз!';
  static const String lookAwayMessage = 'Посмотрите вдаль на 6 метров';
  static const String breakCompleteMessage = 'Перерыв завершен!';
  static const String breakSkippedMessage = 'Перерыв пропущен';
  
  // Правило 20-20-20 (для информационного экрана)
  static const String rule2020description = 
      'Каждые 20 минут смотрите на объект, находящийся на расстоянии 6 метров (20 футов), в течение 20 секунд.';
} 