import 'package:dio/dio.dart';

import 'models/weather_model.dart';


class WeatherRepository {
  
  static const String baseUrl = 'https://api.open-meteo.com/v1/forecast?latitude=55.7522&longitude=37.6156&current=temperature_2m,relative_humidity_2m,precipitation,wind_speed_10m&daily=weather_code,temperature_2m_max,temperature_2m_min,wind_speed_10m_max&timezone=Europe%2FMoscow';
  Dio dio = Dio();

  Future<Weather> getWeather() async {
    late List<Weather> weatherForecast = [];
    final res = await dio.get(baseUrl);
    final currentWeather = Weather.fromJson((res.data));
    weatherForecast.add(currentWeather);

    for (int i = 1; i < 4; i++) {
      late Weather newDayWeather = Weather(
        temperature: res.data['daily']['temperature_2m_max'][i],
        humidity: res.data['daily']['relative_humidity_2m_max'][i],
        windSpeed: res.data['daily']['wind_speed_10m_max'][i],
        weatherCode: res.data['daily']['weather_code'][i],
        precipitation: res.data['daily']['precipitation'][i],
        );

      weatherForecast.add(newDayWeather);
    }
    return currentWeather;
    

  }
}