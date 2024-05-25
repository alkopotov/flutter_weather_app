import 'package:dio/dio.dart';

import 'icon_data.dart';
import 'models/weather_model.dart';


class WeatherRepository {
  
  
  static const String baseUrl = 'https://api.open-meteo.com/v1/forecast?latitude=55.7522&longitude=37.6156&current=temperature_2m,relative_humidity_2m,precipitation_probability,precipitation,weather_code,wind_speed_10m,surface_pressure&daily=sunrise,sunset,weather_code,temperature_2m_max,temperature_2m_min,precipitation_sum,precipitation_probability_max,wind_speed_10m_max&timezone=Europe%2FMoscow';
  Dio dio = Dio();

  Future<List<Weather>> getWeather() async {
    late List<Weather> weatherForecast = [];
    final res = await dio.get(baseUrl);
    final currentWeather = Weather.fromJson((res.data));
    weatherForecast.add(currentWeather);

    for (int i = 1; i <= 3; i++) {
      late Weather newDayWeather = Weather(
        date: DateTime.parse(res.data['daily']['time'][i]),
        temperatureMin: res.data['daily']['temperature_2m_min'][i],
        temperatureMax: res.data['daily']['temperature_2m_max'][i],
        humidity: res.data['current']['relative_humidity_2m'],
        windSpeed: res.data['daily']['wind_speed_10m_max'][i],
        weatherCode: res.data['daily']['weather_code'][i],
        precipitation: res.data['current']['precipitation'],
        weatherIcon: 'assets/images/${icons[res.data['daily']['weather_code'][i] as int] as String}.svg',
        precipitationProbability: res.data['daily']['precipitation_probability_max'][i],
        precipitationSum: res.data['daily']['precipitation_sum'][i],
        pressure: 0.0,
        sunrise: DateTime.parse(res.data['daily']['sunrise'][i]),
        sunset: DateTime.parse(res.data['daily']['sunset'][i]),
        );

      weatherForecast.add(newDayWeather);
    }
    return weatherForecast;
  }
}