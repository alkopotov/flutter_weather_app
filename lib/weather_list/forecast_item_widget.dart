import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/models/weather_model.dart';


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

class ForecastItem extends StatelessWidget {
  const ForecastItem({super.key, required this.data});
  final Weather data;
  
    @override
    Widget build(BuildContext context) {
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