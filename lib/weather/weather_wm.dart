
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/domain/models/weather_model.dart';
import 'package:weather_app/domain/repository_weather.dart';
import 'package:weather_app/weather/weather_model.dart';
import 'package:weather_app/weather/weather_widget.dart';


abstract interface class IWeatherScreenWidgetModel implements IWidgetModel{
  ValueNotifier<EntityState<List<Weather>>> get weatherListenable;
  

  Future<void> loadWeather();

}

WeatherScreenWidgetModel defaultHomeScreenWidgetModelFactory(BuildContext context) {
  return WeatherScreenWidgetModel(WeatherScreenModel(WeatherRepository()));
}


class WeatherScreenWidgetModel extends  WidgetModel<WeatherScreen, IWeatherScreenModel> implements IWeatherScreenWidgetModel{

  WeatherScreenWidgetModel(super.model);

  final _weatherEntity = EntityStateNotifier<List<Weather>>();

  @override
  ValueNotifier<EntityState<List<Weather>>> get weatherListenable => _weatherEntity;


  @override
  void initWidgetModel() {
    loadWeather();
    super.initWidgetModel();
  }
  
  @override
  Future<void> loadWeather() async {
    _weatherEntity.loading();

    final weather = await model.getWeather();
    _weatherEntity.content(weather);
  }

}