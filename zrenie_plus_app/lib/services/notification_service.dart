import '../utils/constants.dart';

/// Временная заглушка для сервиса уведомлений
/// Реальные уведомления отключены из-за проблем с совместимостью
class NotificationService {
  // Инициализация сервиса уведомлений
  Future<void> init() async {
    print('Уведомления временно отключены из-за проблем с совместимостью');
  }
  
  // Отправка уведомления о перерыве
  Future<void> showBreakNotification() async {
    print('Отправка уведомления временно отключена');
  }
  
  // Отмена всех уведомлений
  Future<void> cancelAllNotifications() async {
    // Заглушка
  }
  
  // Запрос разрешений для iOS
  Future<bool> requestIOSPermissions() async {
    // Заглушка
    return true;
  }
} 