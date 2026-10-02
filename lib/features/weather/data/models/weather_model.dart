class WeatherModel {
  final String cityName;
  final String country;
  final double temperature;
  final String mainCondition;
  final String description;
  final double feelsLike;
  final double fahrenheit;
  final int pressure;
  final double uvIndex;
  final int humidity;

  WeatherModel({
    required this.cityName,
    required this.country,
    required this.temperature,
    required this.mainCondition,
    required this.description,
    required this.feelsLike,
    required this.fahrenheit,
    required this.pressure,
    required this.uvIndex,
    required this.humidity,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final name = json['name'] ?? 'Cairo';
    final sys = json['sys'] ?? {};
    final countryCode = sys['country'] ?? 'EG';

    final main = json['main'] ?? {};
    final tempCelsius = (main['temp'] ?? 27.0).toDouble();
    final feels = (main['feels_like'] ?? 28.0).toDouble();
    final press = (main['pressure'] ?? 134).toInt();
    final humid = (main['humidity'] ?? 48).toInt();

    final weatherList = json['weather'] as List?;
    final weatherMain = (weatherList != null && weatherList.isNotEmpty)
        ? weatherList[0]['main'] ?? 'Clear'
        : 'Clear';
    final weatherDesc = (weatherList != null && weatherList.isNotEmpty)
        ? weatherList[0]['description'] ?? 'Clear Sky'
        : 'Clear Sky';

    final tempFahrenheit = (tempCelsius * 9 / 5) + 32;

    const uv = 0.2;

    return WeatherModel(
      cityName: name,
      country: countryCode,
      temperature: tempCelsius,
      mainCondition: weatherMain,
      description: weatherDesc,
      feelsLike: feels,
      fahrenheit: tempFahrenheit,
      pressure: press,
      uvIndex: uv,
      humidity: humid,
    );
  }
}
