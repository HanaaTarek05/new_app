import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
class AppHelpers {
  //الوقت الحالي
  static String getDynamicGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 6 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 18) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
  //تاريخ اليوم
  static String getFormattedCurrentDate() {
    final now = DateTime.now();
    final weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    final dayName = weekdays[now.weekday % 7];
    final dayNum = now.day;
    final monthName = months[now.month - 1];
    final year = now.year;

    return '$dayName $dayNum $monthName, $year';
  }
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }
  static Widget buildHeaderWeatherWidget() {
    //نهار أم ليل
    final hour = DateTime.now().hour;
    final bool isDayTime = hour >= 6 && hour < 18;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isDayTime ? Icons.wb_sunny_rounded : Icons.nights_stay_rounded,
          color: isDayTime ? Colors.amber : Colors.indigoAccent,
          size: 22,
        ),
        const SizedBox(width: 6),
        Text(
          isDayTime ? 'Sunny 32°C' : 'Clear Night 22°C',
          style: const TextStyle(
            fontFamily: 'Lexend_Deca',
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
