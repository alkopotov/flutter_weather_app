class Weather {

  Weather({
    required this.temperature,
    required this.humidity,
    required this.precipitation,
    required this.windSpeed,
    required this.weatherCode,
  });

  final double temperature;
  final int humidity;
  final double precipitation;
  final double windSpeed;
  final int  weatherCode;

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['current']['temperature_2m'] as double,
      humidity: json['current']['relative_humidity_2m'] as int,
      precipitation: json['current']['precipitation'] as double,
      windSpeed: json['current']['wind_speed_10m'] as double,
      weatherCode: json['daily']['weather_code'][0] as int,
    );
  }
}