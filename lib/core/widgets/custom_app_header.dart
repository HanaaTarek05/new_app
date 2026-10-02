import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../utils/app_helpers.dart';

class CustomAppHeader extends StatelessWidget {
  const CustomAppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
      color: AppColors.splashBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppHelpers.getDynamicGreeting(),
                style: const TextStyle(
                  fontFamily: 'Lexend_Deca',
                  fontSize: 13,
                  color: Color(0xFF888888),
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                AppHelpers.getFormattedCurrentDate(),
                style: const TextStyle(
                  fontFamily: 'Lexend_Deca',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          AppHelpers.buildHeaderWeatherWidget(),
        ],
      ),
    );
  }
}
