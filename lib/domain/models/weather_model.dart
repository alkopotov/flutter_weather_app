import 'package:weather_app/domain/icon_data.dart';

class Weather {

  Weather({
    required this.date,
    required this.temperatureMin,
    required this.temperatureMax,
    required this.humidity,
    required this.precipitation,
    required this.windSpeed,
    required this.weatherCode,
    required this.weatherIcon,
    required this.precipitationProbability,
    required this.precipitationSum,
    required this.pressure,
    required this.sunrise,
    required this.sunset
  });
  final DateTime date;
  final double temperatureMin;
  final double temperatureMax;
  final int humidity;
  final double precipitation;
  final double windSpeed;
  final int  weatherCode;
  final String weatherIcon;
  final int precipitationProbability;
  final double precipitationSum;
  final double pressure;
  final DateTime sunrise;
  final DateTime sunset;

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      date: DateTime.parse(json['current']['time'].toString()),
      temperatureMin: json['current']['temperature_2m'] as double,
      temperatureMax: json['current']['temperature_2m'] as double,
      humidity: json['current']['relative_humidity_2m'] as int,
      precipitation: json['current']['precipitation'] as double,
      windSpeed: json['current']['wind_speed_10m'] as double,
      weatherCode: json['current']['weather_code'] as int,
      weatherIcon: 'assets/images/${icons[json['current']['weather_code'] as int] as String}.svg',
      precipitationProbability: json['current']['precipitation_probability'] as int,
      precipitationSum: json['daily']['precipitation_sum'][0] as double,
      pressure: (json['current']['surface_pressure'] as double) / 1.33322,
      sunrise: DateTime.parse(json['daily']['sunrise'][0]),
      sunset: DateTime.parse(json['daily']['sunset'][0]),
    );
  }
}