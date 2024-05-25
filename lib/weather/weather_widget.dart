import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/models/weather_model.dart';
import 'package:weather_app/weather/weather_wm.dart';

class WeatherScreen extends ElementaryWidget<IWeatherScreenWidgetModel> {
  const WeatherScreen({super.key}) : super(defaultHomeScreenWidgetModelFactory);

  Color getColor(double temp) {
    switch (temp) {
      case < -5:
        return const Color.fromARGB(255, 13, 70, 156);
      case < 2:
        return const Color.fromARGB(255, 31, 101, 206);
      case < 12:
        return Colors.blue;
      case < 16:
        return const Color.fromARGB(255, 33, 145, 125);
      case < 22:
        return Colors.greenAccent;
      case < 25:
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(IWeatherScreenWidgetModel wm) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(children: [
            // const SizedBox(height: 10),
            EntityStateNotifierBuilder<List<Weather>>(
              listenableEntityState: wm.weatherListenable,
              loadingBuilder: (context, data) => const Text('Loading...'),
              errorBuilder: (context, e, data) => const Text('Error'),
              builder: (context, List<Weather>? data) {
                return Column(
                  children: [
                    Stack(alignment: Alignment.center, children: [
                      SvgPicture.asset(data![0].weatherIcon,
                          width: 166, height: 166),
                      Container(
                        width: double.infinity,
                        height: 260,
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${data[0].temperatureMax.toString()}°C',
                                        style: TextStyle(
                                          fontSize: 40,
                                          color:
                                              getColor(data[0].temperatureMin),
                                        ),
                                      ),
                                      Text(
                                        DateFormat('dd.MM.yy')
                                            .format(data[0].date),
                                        style: const TextStyle(
                                          fontSize: 36,
                                        ),
                                      )
                                    ]),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset('assets/images/sunrise.png',
                                            width: 42, height: 42),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(DateFormat('HH:mm')
                                              .format(data[0].sunrise)),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(DateFormat('HH:mm')
                                              .format(data[0].sunset)),
                                        ),
                                        Image.asset('assets/images/sunset.png',
                                            width: 42, height: 42),
                                      ],
                                    ),
                                  ]),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.water_drop_outlined,
                                            size: 40),
                                        Column(
                                          children: [
                                            Text(
                                                '${data[0].precipitation.toString()} мм'),
                                            Text(
                                                '${data[0].precipitationProbability.toString()}%'),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(data[0].windSpeed.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const Text('м/с',
                                                  style:
                                                      TextStyle(fontSize: 10)),
                                            ],
                                          ),
                                        ),
                                        const Icon(Icons.wind_power_outlined,
                                            size: 36, color: Colors.blue),
                                      ],
                                    ),
                                  ]),
                              const SizedBox(
                                height: 18,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/images/hygrometer.svg',
                                              width: 36,
                                              height: 36),
                                          Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Text(
                                                '${data[0].humidity.toString()}%',
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                  data[0]
                                                      .pressure
                                                      .toStringAsFixed(0),
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const Text('мм.рт.ст',
                                                  style:
                                                      TextStyle(fontSize: 10)),
                                            ],
                                          ),
                                          SvgPicture.asset(
                                              'assets/images/barometer.svg',
                                              width: 38,
                                              height: 38,
                                              color: Colors.blue),
                                        ],
                                      )
                                    ]),
                              )
                            ],
                          ),
                        ),
                      ),
                    ]),
                    Text('Прогноз на ${data.length - 1} дня',
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    ...data.sublist(1).map((e) => forecastItem(data: e)),
                    ElevatedButton(
                        onPressed: () {
                          wm.loadWeather();
                        },
                        child: const Text('Обновить'))
                  ],
                );
              },
            )
          ]),
        ));
  }

  Widget forecastItem({required Weather data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                width: 96,
                height: 96,
                child: SvgPicture.asset(
                  data.weatherIcon,
                  fit: BoxFit.fitHeight,
                )),
            const SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Image.asset('assets/images/sunrise.png',
                            width: 24, height: 24),
                        Text(DateFormat('HH:mm').format(data.sunrise),
                            style: const TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w300)),
                      ],
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      DateFormat('dd.MM.yy').format(data.date),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Column(
                      children: [
                        Image.asset('assets/images/sunset.png',
                            width: 24, height: 24),
                        Text(DateFormat('HH:mm').format(data.sunset),
                            style: const TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w300)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${data.temperatureMin.toStringAsFixed(0)}°C',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: getColor(data.temperatureMin),
                      ),
                    ),
                    const Text(' - ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(
                      '${data.temperatureMax.toStringAsFixed(0)}°C',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: getColor(data.temperatureMax),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.water_drop_outlined,
                    size: 48, color: Colors.blue[800]),
                Text(
                  '${data.precipitationProbability.toStringAsFixed(0)}%',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text('${data.precipitationSum.toStringAsFixed(0)} мм',
                    style: const TextStyle(fontSize: 12)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
