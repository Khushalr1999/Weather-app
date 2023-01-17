import 'dart:convert';

import 'package:climate_app/Screens/City_Screen.dart';
import 'package:climate_app/services/weather.dart';
import 'package:climate_app/utility/constants.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;
  LocationScreen(this.locationWeather);
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  var condition;
  var temp;
  String? city;
  void initState() {
    super.initState();
    UpdateUI(widget.locationWeather);
  }

  WeatherModel weather = new WeatherModel();
  void UpdateUI(dynamic weatherdata) {
    setState(() {
      if (weatherdata == null) {
        temp = 0;
        return;
      }
      double temperature = weatherdata['main']['temp'];
      condition = weatherdata['weather'][0]['id'];
      weather.getWeatherIcon(condition);
      temp = temperature.toInt();
      city = weatherdata['name'];
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() async {
                        var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ),
                        );
                        if (typedName != null) {
                          var weatherdata = await weather.getLocationWeather();
                          UpdateUI(weatherdata);
                        }
                        ;
                      });
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() async {
                        var weatherdata = await weather.getLocationWeather();
                        UpdateUI(weatherdata);
                      });
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '${weather.getWeatherIcon(condition)}',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  '${weather.getMessage(temp)} $city',
                  textAlign: TextAlign.left,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
