#!/bin/bash

# Путь к Android SDK
ANDROID_SDK_PATH="$HOME/Library/Android/sdk"
EMULATOR_PATH="$ANDROID_SDK_PATH/emulator"
PLATFORM_TOOLS_PATH="$ANDROID_SDK_PATH/platform-tools"

# Имя AVD (Android Virtual Device)
AVD_NAME="Pixel_API33"

# Останавливаем запущенные эмуляторы
echo "Остановка запущенных эмуляторов..."
$PLATFORM_TOOLS_PATH/adb devices | grep emulator | cut -f1 | while read line; do
    echo "Остановка $line"
    $PLATFORM_TOOLS_PATH/adb -s $line emu kill
done

# Запускаем эмулятор с увеличенным объемом памяти и хранилища
echo "Запуск эмулятора $AVD_NAME..."
$EMULATOR_PATH/emulator -avd $AVD_NAME -memory 4096 -partition-size 4096 -wipe-data -no-snapshot-load -no-boot-anim &

# Ожидаем полной загрузки эмулятора
echo "Ожидание загрузки эмулятора..."
$PLATFORM_TOOLS_PATH/adb wait-for-device

# Показываем, что эмулятор загружен
echo "Эмулятор запущен и готов к использованию!"

# Функция мониторинга логов
function monitor_logs {
    echo "Начало мониторинга логов. Для остановки нажмите Ctrl+C"
    $PLATFORM_TOOLS_PATH/adb logcat | grep -E "zrenie|flutter|error|crash"
}

# Функция очистки данных приложения
function clear_app_data {
    echo "Очистка данных приложения..."
    $PLATFORM_TOOLS_PATH/adb shell pm clear com.zrenieplus.zrenie_plus_app
    echo "Данные приложения очищены!"
}

# Функция установки APK в режиме отладки
function install_debug_apk {
    echo "Установка debug APK..."
    cd $(dirname "$0")/../
    flutter build apk --debug --split-per-abi
    $PLATFORM_TOOLS_PATH/adb install -r build/app/outputs/flutter-apk/app-arm64-v8a-debug.apk
    echo "APK установлен!"
}

# Показываем доступные команды
echo ""
echo "Доступные команды:"
echo "1 - Мониторинг логов"
echo "2 - Очистка данных приложения"
echo "3 - Установка debug APK"
echo "q - Выход"

# Обработка команд
while true; do
    read -p "Введите команду: " cmd
    case $cmd in
        1) monitor_logs ;;
        2) clear_app_data ;;
        3) install_debug_apk ;;
        q) echo "Выход"; exit 0 ;;
        *) echo "Неизвестная команда" ;;
    esac
done 