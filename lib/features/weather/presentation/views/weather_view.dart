import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/app_helpers.dart';
import '../../../../core/widgets/custom_app_header.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../location/presentation/views/location_view.dart';
import '../../data/models/weather_model.dart';
import '../../data/services/weather_service.dart';

class WeatherView extends StatefulWidget {
static const String routeName = '/weather';

const WeatherView({super.key});

@override
State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
final WeatherService _weatherService = WeatherService();
late Future<WeatherModel?> _weatherFuture;

final List<Map<String, dynamic>> _hourlyForecast = [
{'time': 'Now', 'temp': '26°', 'icon': Icons.wb_sunny_rounded},
{'time': '2 PM', 'temp': '27°', 'icon': Icons.wb_sunny_rounded},
{'time': '4 PM', 'temp': '28°', 'icon': Icons.wb_cloudy_rounded},
{'time': '6 PM', 'temp': '25°', 'icon': Icons.wb_sunny_rounded},
{'time': '8 PM', 'temp': '23°', 'icon': Icons.nights_stay_rounded},
{'time': '10 PM', 'temp': '22°', 'icon': Icons.nights_stay_rounded},
];

@override
void initState() {
super.initState();
_weatherFuture = _weatherService.fetchWeather();
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.white,
body: SafeArea(
child: Column(
children: [

const CustomAppHeader(),


Expanded(
child: FutureBuilder<WeatherModel?>(
future: _weatherFuture,
builder: (context, snapshot) {
final weather = snapshot.data ??
WeatherModel(
cityName: 'Zagazig',
country: 'EG',
temperature: 26,
mainCondition: 'Clouds',
description: 'Broken Clouds',
feelsLike: 26,
fahrenheit: 79,
pressure: 1016,
uvIndex: 0.2,
humidity: 42,
);

return LayoutBuilder(
builder: (context, constraints) {
return SingleChildScrollView(
physics: const BouncingScrollPhysics(),
child: ConstrainedBox(
constraints: BoxConstraints(
minHeight: constraints.maxHeight,
),
child: Padding(
padding: const EdgeInsets.symmetric(
horizontal: 24, vertical: 12),
child: Column(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
crossAxisAlignment: CrossAxisAlignment.start,
children: [

Row(
  mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            '${weather.cityName} - ${weather.country}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Lexend_Deca',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${weather.temperature.round()}°',
            style: const TextStyle(
              fontFamily: 'Lexend_Deca',
              fontSize: 60,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${weather.mainCondition} - ${AppHelpers.capitalize(weather.description)}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Lexend_Deca',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Feels like ${weather.feelsLike.round()}°',
            style: const TextStyle(
              fontFamily: 'Lexend_Deca',
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    ),
    const SizedBox(width: 8),
    Container(
      padding: const EdgeInsets.only(top: 8),
      child: const Icon(
        Icons.wb_sunny_rounded,
        size: 64,
        color: Colors.amber,
      ),
    ),
  ],
),

const SizedBox(height: 16),


Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: AppColors.splashBackground,
    borderRadius: BorderRadius.circular(20),
  ),
  child: Column(
    children: [
      Row(
        children: [
          Expanded(
            child: _buildMetricTile(
              icon: Icons.thermostat_rounded,
              iconColor: AppColors.primaryBlue,
              value:
                  '${weather.fahrenheit.round()}°',
              label: 'Fahrenheit',
            ),
          ),
          Expanded(
            child: _buildMetricTile(
              icon: Icons.air_rounded,
              iconColor: AppColors.primaryBlue,
              value: '${weather.pressure} mp/h',
              label: 'Pressure',
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      Row(
        children: [
          Expanded(
            child: _buildMetricTile(
              icon: Icons.wb_sunny_outlined,
              iconColor: AppColors.primaryBlue,
              value: '${weather.uvIndex}',
              label: 'UV Index',
            ),
          ),
          Expanded(
            child: _buildMetricTile(
              icon: Icons.water_drop_outlined,
              iconColor: AppColors.primaryBlue,
              value: '${weather.humidity}%',
              label: 'Humidity',
            ),
          ),
        ],
      ),
    ],
  ),
),

const SizedBox(height: 16),


Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    const Text(
      'Hourly Forecast',
      style: TextStyle(
        fontFamily: 'Lexend_Deca',
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    ),
    const SizedBox(height: 10),
    SizedBox(
      height: 75,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _hourlyForecast.length,
        separatorBuilder: (context, index) =>
            const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = _hourlyForecast[index];
          return Container(
            width: 60,
            padding: const EdgeInsets.symmetric(
                vertical: 8),
            decoration: BoxDecoration(
              color: index == 0
                  ? AppColors.primaryBlue
                      .withValues(alpha: 0.1)
                  : Colors.white,
              borderRadius:
                  BorderRadius.circular(14),
              border: Border.all(
                color: index == 0
                    ? AppColors.primaryBlue
                    : Colors.grey.shade200,
              ),
            ),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceEvenly,
              children: [
                Text(
                  item['time'],
                  style: TextStyle(
                    fontFamily: 'Lexend_Deca',
                    fontSize: 11,
                    color: index == 0
                        ? AppColors.primaryBlue
                        : AppColors.textSecondary,
                    fontWeight: index == 0
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                Icon(
                  item['icon'] as IconData,
                  size: 18,
                  color: index == 0
                      ? AppColors.primaryBlue
                      : Colors.amber,
                ),
                Text(
                  item['temp'],
                  style: const TextStyle(
                    fontFamily: 'Lexend_Deca',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
  ],
),

const SizedBox(height: 16),


Center(
  child: CustomButton(
    text: 'Change Location',
    icon: Icons.location_on_rounded,
    onPressed: () {
      Navigator.of(context)
          .pushNamed(LocationView.routeName);
    },
    horizontalPadding: 32,
    verticalPadding: 14,
    borderRadius: 24,
  ),
),
],
),
),
),
);
},
);
},
),
),


const CustomBottomNavBar(activeIndex: 3),
],
),
),
);
}

Widget _buildMetricTile({
required IconData icon,
required Color iconColor,
required String value,
required String label,
}) {
return Row(
children: [
Icon(
icon,
size: 28,
color: iconColor,
),
const SizedBox(width: 10),
Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
value,
style: const TextStyle(
fontFamily: 'Lexend_Deca',
fontSize: 15,
fontWeight: FontWeight.bold,
color: AppColors.primaryBlue,
),
),
const SizedBox(height: 2),
Text(
label,
style: const TextStyle(
fontFamily: 'Lexend_Deca',
fontSize: 11,
color: AppColors.textSecondary,
),
),
],
),
],
);
}
}
