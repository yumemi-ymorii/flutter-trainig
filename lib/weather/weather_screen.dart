import 'package:flutter/material.dart';
import 'package:flutter_training/weather/weather_panel.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<StatefulWidget> createState() => _WeatherScreen();
}

class _WeatherScreen extends State<WeatherScreen> {
  String? _weatherCodition;

  void _reloadWeatherCondition() {
    final yumemiWeather = YumemiWeather();
    setState(() {
      _weatherCodition = yumemiWeather.fetchSimpleWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          alignment: FractionalOffset.center,
          child: Column(
            children: <Widget>[
              const Spacer(),
              WeatherPanel(
                weatherCondition: _weatherCodition,
              ),
              Flexible(
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    _Buttons(
                      onReloaded: _reloadWeatherCondition,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({
    required void Function() onReloaded,
  }) : _onReloaded = onReloaded;
  final VoidCallback _onReloaded;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final textWidth = screenSize.width / 4;

    return Row(
      children: [
        SizedBox(
          width: textWidth,
          child: Center(
            child: TextButton(
              // 後で関数にしたい
              onPressed: () {},
              child: const Text('Close'),
            ),
          ),
        ),
        SizedBox(
          width: textWidth,
          child: Center(
            child: TextButton(
              onPressed: _onReloaded,
              child: const Text('Reload'),
            ),
          ),
        ),
      ],
    );
  }
}