import 'package:climate_app/Screens/City_Screen.dart';
import 'package:climate_app/services/location.dart';
import 'package:climate_app/services/networking.dart';

const apiKey = '9e2b18b7d79081ce6e7e01fafe6a85e7';
const openWeatherMapURL = 'http://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityname) async {
    NetworkHelp net =
        new NetworkHelp('$openWeatherMapURL?q=$cityname&appid=$apiKey');
    var weatherdata = await net.getData();
    return weatherdata;
  }

  Future<dynamic> getLocationWeather() async {
    Location locate = new Location();
    await locate.getCurrentLocation();

    NetworkHelp net = new NetworkHelp(
        '$openWeatherMapURL?lat=${locate.latitude}&lon=${locate.longitude}&appid=$apiKey&units=metric');
    var weatherdata = await net.getData();
    return weatherdata;
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
