import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import '../services/storage_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late Map<String, dynamic> _settings;
  
  @override
  void initState() {
    super.initState();
    _loadSettings();
  }
  
  void _loadSettings() {
    final storageService = Provider.of<StorageService>(context, listen: false);
    setState(() {
      _settings = storageService.getSettings();
    });
  }
  
  void _saveSettings() async {
    final storageService = Provider.of<StorageService>(context, listen: false);
    await storageService.saveSettings(_settings);
    
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Настройки сохранены'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Заголовок
            Text(
              'Настройки',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            
            const SizedBox(height: 24),
            
            // Настройка времени работы
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Таймеры',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Настройка времени работы
                    Row(
                      children: [
                        const Expanded(
                          child: Text('Время между перерывами:'),
                        ),
                        Text(
                          '${_settings['workMinutes']} мин',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Slider(
                      value: _settings['workMinutes'].toDouble(),
                      min: AppConstants.minimumWorkMinutes.toDouble(),
                      max: AppConstants.maximumWorkMinutes.toDouble(),
                      divisions: 11, // 5-60 минут с шагом 5
                      label: "${_settings['workMinutes']} мин",
                      onChanged: (value) {
                        setState(() {
                          _settings['workMinutes'] = value.round();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Настройки внешнего вида
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Внешний вид',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Переключатель темной темы
                    SwitchListTile(
                      title: const Text('Темная тема'),
                      value: _settings['isDarkMode'],
                      onChanged: (value) {
                        setState(() {
                          _settings['isDarkMode'] = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Кнопка сохранения настроек
            FilledButton(
              onPressed: _saveSettings,
              child: const Text('Сохранить настройки'),
            ),
          ],
        ),
      ),
    );
  }
} 