
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/domain/models/weather_model.dart';
import 'package:weather_app/domain/repository.dart';
import 'package:weather_app/home/home_model.dart';
import 'package:weather_app/home/home_widget.dart';


abstract interface class IWeatherScreenWidgetModel implements IWidgetModel{
  ValueNotifier<EntityState<Weather>> get weatherListenable;
}

WeatherScreenWidgetModel defaultHomeScreenWidgetModelFactory(BuildContext context) {
  return WeatherScreenWidgetModel(WeatherScreenModel(WeatherRepository()));
}


class WeatherScreenWidgetModel extends  WidgetModel<WeatherScreen, IWeatherScreenModel> implements IWeatherScreenWidgetModel{

  WeatherScreenWidgetModel(super.model);

  final _weatherEntity = EntityStateNotifier<Weather>();

  @override
  ValueNotifier<EntityState<Weather>> get weatherListenable => _weatherEntity;


  @override
  void initWidgetModel() {
    _loadWeather();
    super.initWidgetModel();
  }


  Future<void> _loadWeather() async {
    _weatherEntity.loading();

    final weather = await model.getWeather();
    _weatherEntity.content(weather);
  }

}