import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/domain/models/weather_model.dart';
import 'package:weather_app/home/home_wm.dart';

class WeatherScreen extends ElementaryWidget<IWeatherScreenWidgetModel> {
  const WeatherScreen({super.key}) : super(defaultHomeScreenWidgetModelFactory);

  @override
  Widget build(IWeatherScreenWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 120),
            const Text('Current weather'),
            EntityStateNotifierBuilder<Weather>(listenableEntityState: wm.weatherListenable,
            loadingBuilder: (context, data) => const Text('Loading...'),
            errorBuilder: (context, e, data) => const Text('Error'),
            builder: (context, Weather ? data) {
               return Column(
                 children: [
                   Text('Влажность: ${data!.humidity.toString()} %'),
                   Text('Температура: ${data.temperature.toString()} °C'),
                   Text('Скорость ветра: ${data.windSpeed.toString()} м/с'),
                   Text('Погода: ${data.weatherCode.toString()}'),
                 ],
               );
              },
            )
          ]
        ),
      )
    );
  }
}