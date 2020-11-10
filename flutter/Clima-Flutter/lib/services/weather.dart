import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

class WeatherModel {
  String apiKey = 'd091a95895c3c04df100dc9ba30cedcc';
  String weatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

  Future getWeatherData() async {
    Location location = Location();
    await location.getCurrentLocation();
    final NetworkHelper networkHelper =  NetworkHelper(
        '$weatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric'
    );
    final weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future getWeatherCity(String cityName) async {
    final NetworkHelper networkHelper = NetworkHelper(
      '$weatherMapURL?q=$cityName&appid=$apiKey&units=metric'
    );
    final weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
