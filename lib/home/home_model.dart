

import 'package:elementary/elementary.dart';
import 'package:weather_app/domain/repository.dart';

import '../domain/models/weather_model.dart';

abstract interface class IWeatherScreenModel extends ElementaryModel {
  Future<Weather> getWeather();
}


class WeatherScreenModel extends  IWeatherScreenModel {
  WeatherScreenModel(this._weatherRepository,);
  final WeatherRepository _weatherRepository;
  @override
  Future<Weather> getWeather() async => _weatherRepository.getWeather();
}
