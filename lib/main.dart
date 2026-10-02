import 'package:flutter/material.dart';
import 'core/constants/app_colors.dart';
import 'features/bookmark/presentation/views/bookmark_view.dart';
import 'features/explore/presentation/views/article_detail_view.dart';
import 'features/explore/presentation/views/explore_view.dart';
import 'features/explore/presentation/views/search_results_view.dart';
import 'features/explore/presentation/views/search_view.dart';
import 'features/home/presentation/views/home_view.dart';
import 'features/home/presentation/views/popular_news_view.dart';
import 'features/location/presentation/views/location_view.dart';
import 'features/splash/presentation/views/splash_view.dart';
import 'features/weather/presentation/views/weather_view.dart';
import 'features/welcome/presentation/views/welcome_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Khabər',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Lexend_Deca',
        scaffoldBackgroundColor: AppColors.splashBackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryBlue,
          surface: AppColors.splashBackground,
        ),
        useMaterial3: true,
      ),
      initialRoute: SplashView.routeName,
      routes: {
        SplashView.routeName: (context) => const SplashView(),
        WelcomeView.routeName: (context) => const WelcomeView(),
        LocationView.routeName: (context) => const LocationView(),
        HomeView.routeName: (context) => const HomeView(),
        PopularNewsView.routeName: (context) => const PopularNewsView(),
        ExploreView.routeName: (context) => const ExploreView(),
        ArticleDetailView.routeName: (context) => const ArticleDetailView(),
        SearchView.routeName: (context) => const SearchView(),
        SearchResultsView.routeName: (context) => const SearchResultsView(),
        BookmarkView.routeName: (context) => const BookmarkView(),
        WeatherView.routeName: (context) => const WeatherView(),
      },
    );
  }
}
