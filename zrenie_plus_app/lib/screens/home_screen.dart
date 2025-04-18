import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import '../services/notification_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer _timer;
  int _secondsRemaining = AppConstants.defaultWorkMinutes * 60;
  bool _isTimerRunning = false;
  int _totalSeconds = AppConstants.defaultWorkMinutes * 60;
  
  @override
  void initState() {
    super.initState();
    // Загружаем настройки пользователя
    _loadSettings();
  }
  
  @override
  void dispose() {
    if (_isTimerRunning) {
      _timer.cancel();
    }
    super.dispose();
  }
  
  void _loadSettings() {
    // Здесь будет загрузка настроек пользователя из StorageService
    // Пока используем значения по умолчанию
    _secondsRemaining = AppConstants.defaultWorkMinutes * 60;
    _totalSeconds = _secondsRemaining;
  }
  
  void _startTimer() {
    setState(() {
      _isTimerRunning = true;
    });
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel();
          _isTimerRunning = false;
          _showBreakScreen();
        }
      });
    });
  }
  
  void _pauseTimer() {
    if (_isTimerRunning) {
      _timer.cancel();
      setState(() {
        _isTimerRunning = false;
      });
    }
  }
  
  void _resetTimer() {
    if (_isTimerRunning) {
      _timer.cancel();
    }
    setState(() {
      _secondsRemaining = _totalSeconds;
      _isTimerRunning = false;
    });
  }
  
  void _showBreakScreen() async {
    // Получаем сервис уведомлений
    final notificationService = Provider.of<NotificationService>(context, listen: false);
    
    // Показываем уведомление
    await notificationService.showBreakNotification();
    
    if (!mounted) return;
    
    // В полной реализации здесь будет переход на экран перерыва
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Пора сделать перерыв!'),
        duration: Duration(seconds: 3),
      ),
    );
    
    _resetTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Таймер
              _buildTimerDisplay(),
              
              const SizedBox(height: 40),
              
              // Кнопки управления
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Кнопка Старт/Пауза
                  FilledButton.icon(
                    onPressed: _isTimerRunning ? _pauseTimer : _startTimer,
                    icon: Icon(_isTimerRunning ? Icons.pause : Icons.play_arrow),
                    label: Text(_isTimerRunning ? 'Пауза' : 'Старт'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24, 
                        vertical: 12,
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // Кнопка Сброс
                  OutlinedButton.icon(
                    onPressed: _resetTimer,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Сброс'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24, 
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 40),
              
              // Информация о правиле 20-20-20
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  AppConstants.rule2020description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildTimerDisplay() {
    final minutes = _secondsRemaining ~/ 60;
    final seconds = _secondsRemaining % 60;
    final timeText = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    final progress = 1 - (_secondsRemaining / _totalSeconds);
    
    return Column(
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Прогресс
              CircularProgressIndicator(
                value: progress,
                strokeWidth: 10,
                backgroundColor: Colors.grey.withOpacity(0.2),
              ),
              
              // Текст таймера
              Text(
                timeText,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text('До перерыва'),
      ],
    );
  }
} 