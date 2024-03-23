import 'package:flutter/material.dart';
import 'package:flutter_weather_app/viewModel/weather_page_view_model.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  @override
  void initState() {
    super.initState();
    Provider.of<WeatherPageViewModel>(context, listen: false).fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Consumer<WeatherPageViewModel>(
        builder: (context, viewModel, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.grey,
                      size: 32,
                    ),
                    // city name
                    Text(
                      viewModel.weather?.cityName ?? "Loading City..",
                      style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                      ),
                    ),
                  ],
                ),
                // animations
                Lottie.asset(viewModel.getWeatherAnimation(viewModel.weather?.mainCondititon)),
                // tempature
                Text(
                  "${viewModel.weather?.temperature.round()}°",
                  style: const TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87
                  ),
                ),
                // weather condition
                //Text(_weather?.mainCondititon ?? "",style: TextStyle(color: Colors.black),),
              ],
            ),
          );
        },
    );
  }
}