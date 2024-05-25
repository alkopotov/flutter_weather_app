

import 'package:elementary/elementary.dart';
import 'package:weather_app/domain/repository_weather.dart';

import '../domain/models/weather_model.dart';

abstract interface class IWeatherScreenModel extends ElementaryModel {
  Future<List<Weather>> getWeather();
}


class WeatherScreenModel extends  IWeatherScreenModel {
  WeatherScreenModel(this._weatherRepository,);
  final WeatherRepository _weatherRepository;
  @override
  Future<List<Weather>> getWeather() async => _weatherRepository.getWeather();
}
