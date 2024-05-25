import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/models/weather_model.dart';

class ForecastItem {
  Widget build({required Weather data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                width: 100,
                height: 100,
                child: SvgPicture.asset(
                  data.weatherIcon,
                  fit: BoxFit.fitHeight,
                )),
            const SizedBox(
              width: 16,
            ),
            Column(
              children: [
                Row(
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
                    Text(
                      DateFormat('dd.MM.yy').format(data.date),
                      style: TextStyle(
                        fontSize: 20,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}