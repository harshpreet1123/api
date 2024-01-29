import 'package:api/constants/api_key.dart';
import 'package:api/models/weather_model.dart';
import 'package:api/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WeateherPage extends StatefulWidget {
  const WeateherPage({super.key});

  @override
  State<WeateherPage> createState() => _WeateherPageState();
}

class _WeateherPageState extends State<WeateherPage> {
  final _weatherService = WeatherService(api_key);

  Weather? _weather;

  _fetchWeather() async {
    String city = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(city);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  getWeatherAnimation(String? condition) {
    if (condition == null) {
      return 'assets/sunny.json';
    }
    switch (condition.toLowerCase()) {
      case 'clouds':
        return 'assets/cloud.json';
      case 'clear':
        return 'assets/sunny.json';
      case 'fog':
        return 'assets/partly.json';
      case 'shower rain':
        return 'assets/rain.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_weather?.city ?? 'Loading...'),
          Lottie.asset(getWeatherAnimation(_weather?.condition)),
          Text('${_weather?.temp.round()} °C')
        ],
      ),
    ));
  }
}
