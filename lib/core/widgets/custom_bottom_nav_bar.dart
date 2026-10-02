import 'package:flutter/material.dart';
import '../../features/bookmark/presentation/views/bookmark_view.dart';
import '../../features/explore/presentation/views/explore_view.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../../features/weather/presentation/views/weather_view.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int activeIndex;

  const CustomBottomNavBar({
    super.key,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0F2), // Light pastel background
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildItem(context, 0, Icons.home_rounded, 'Home'),
          _buildItem(context, 1, Icons.public_rounded, 'Explore'),
          _buildItem(context, 2, Icons.bookmark_rounded, 'Bookmark'),
          _buildItem(context, 3, Icons.wb_sunny_rounded, 'Weather'),
        ],
      ),
    );
  }

  Widget _buildItem(
      BuildContext context, int index, IconData icon, String label) {
    final bool isSelected = activeIndex == index;

    return GestureDetector(
      onTap: () {
        if (index == activeIndex) return;

        if (index == 0) {
          Navigator.of(context).pushReplacementNamed(HomeView.routeName);
        } else if (index == 1) {
          Navigator.of(context).pushReplacementNamed(ExploreView.routeName);
        } else if (index == 2) {
          Navigator.of(context).pushReplacementNamed(BookmarkView.routeName);
        } else if (index == 3) {
          Navigator.of(context).pushReplacementNamed(WeatherView.routeName);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: isSelected
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF222222), // Active dark pill container
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Icon(icon, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: const TextStyle(
                      fontFamily: 'Lexend_Deca',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              child: Icon(
                icon,
                color: Colors.black87,
                size: 22,
              ),
            ),
    );
  }
}
