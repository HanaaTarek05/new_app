import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../home/presentation/views/home_view.dart';

class WelcomeView extends StatelessWidget {
  static const String routeName = '/welcome';

  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF255BEB),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [

            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                color: const Color(0xFF255BEB),
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  AppImages.modernBuilding,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox();
                  },
                ),
              ),
            ),


            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(28, 28, 28, 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Title
                    const Text(
                      'Get The Latest News\nAnd Updates',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Lexend_Deca',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        height: 1.25,
                      ),
                    ),


                    const Text(
                      'From Politics to Entertainment: Your One-Stop Source for Comprehensive Coverage of the Latest News and Developments Across the Glob will be right on your hand.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Lexend_Deca',
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                        height: 1.45,
                      ),
                    ),


                    CustomButton(
                      text: 'Explore',
                      icon: Icons.arrow_forward_rounded,
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(HomeView.routeName);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
