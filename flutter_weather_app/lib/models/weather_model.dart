class Weather{
  final String cityName;
  final double temperature;
  final String mainCondititon;
  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondititon
  });
  factory Weather.fromJson(Map<String, dynamic> json){
    return Weather(
      cityName: json["name"], 
      temperature: json["main"]["temp"].toDouble(), 
      mainCondititon: json["weather"][0]["main"],
    );
  }
}