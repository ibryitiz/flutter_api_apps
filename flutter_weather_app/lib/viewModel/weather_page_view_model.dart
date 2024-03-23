import 'package:flutter/cupertino.dart';

import '../models/weather_model.dart';
import '../service/weather_service.dart';

class WeatherPageViewModel with ChangeNotifier {
  final _weatherService = WeatherService("63afe3a1fa67d9691634015eaf975862");
  Weather? _weather;

  Weather? get weather => _weather;

  Future<void> fetchWeather() async {
    try {
      // get the current city
      String cityName = await _weatherService.getCurrentCirty();

      // get weather for city
      final weather = await _weatherService.getWeather(cityName);
      _weather = weather;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return "assets/sunny.json";

    switch (mainCondition.toLowerCase()) {
      case "clouds":
      case "mist":
      case "smoke":
      case "haze":
      case "fog":
        return "assets/cloud.json";
      case "rain":
      case "drizzle":
      case "shower rain":
        return "assets/rain.json";
      case "thunderstorm":
        return "assets/thunder.json";
      case "clear":
        return "assets/sunny.json";
      default:
        return "assets/sunny.json";
    }
  }
}
