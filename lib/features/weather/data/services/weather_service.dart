import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/weather_model.dart';

class WeatherService {
  final Dio _dio = Dio();

  final String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<WeatherModel?> fetchWeather() async {
    try {
      var response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'lat': 30.5877893,
          'lon': 31.4798788,
          'appid': '39ef56aa87e0f9d833e66cd9111de959',
          'units': 'metric',
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return WeatherModel.fromJson(response.data);
      }
    } catch (e) {
      _handleException(e);
    }
    return null;
  }

  void _handleException(Object e) {
    if (e is DioException) {
      if (e.response?.data != null) {
        var errorResponse = e.response?.data;
        if (errorResponse is Map<String, dynamic>) {
          debugPrint('API Error: ${errorResponse['message']}');
        } else {
          debugPrint('API Error: $errorResponse');
        }
      } else {
        debugPrint('Network error happened try again later');
      }
    } else {
      debugPrint('error happened try again later');
    }
  }
}
