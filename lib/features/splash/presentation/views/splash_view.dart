import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../welcome/presentation/views/welcome_view.dart';

class SplashView extends StatefulWidget {
  static const String routeName = '/';

  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer(const Duration(seconds: 3), () {
      _navigateToWelcome();
    });
  }

  void _navigateToWelcome() {
    if (mounted) {
      _timer?.cancel();
      Navigator.of(context).pushReplacementNamed(WelcomeView.routeName);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: AppColors.splashBackground,
body: GestureDetector(
onTap: _navigateToWelcome,
behavior: HitTestBehavior.opaque,
child: SafeArea(
child: Center(
child: Image.asset(
AppImages.logo,
height: 48,
fit: BoxFit.contain,
errorBuilder: (context, error, stackTrace) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'Khab',
        style: TextStyle(
          fontFamily: 'Lexend_Deca',
          fontSize: 44,
          fontWeight: FontWeight.w800,
          color: AppColors.primaryBlue,
          height: 1.0,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.0),
        child: Image.asset(
          AppImages.paper,
          height: 34,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.article_rounded,
              size: 34,
              color: AppColors.primaryBlue,
            );
          },
        ),
      ),
      Text(
        'r',
        style: TextStyle(
          fontFamily: 'Lexend_Deca',
          fontSize: 44,
          fontWeight: FontWeight.w800,
          color: AppColors.primaryBlue,
          height: 1.0,
        ),
      ),
    ],
  );
},
),
),
),
),
);
}
}
