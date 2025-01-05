import 'package:flutter/material.dart';
import 'package:weather_app/screens/city_screen.dart';
import '../utilities/constants.dart';
import 'package:weather_app/services/weather.dart';

class LocationScreen extends StatefulWidget {
 const  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int weatherTemperature = 0;
  String weatherIcon = '';
  String weatherCity = '';
  String weatherMessage = '';

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
        if (weatherData == null) {
          weatherTemperature = 0;
          weatherIcon = '❌';
          weatherMessage = 'Unable to fetch weather data';
          weatherCity = '';
          return;
      }
      double temp = weatherData['main']['temp'];
      weatherTemperature = temp.toInt();
      var weatherCondition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(weatherCondition);
      weatherMessage = weather.getMessage(weatherTemperature);
      weatherCity = weatherData['name'];
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
              Colors.black.withOpacity(0.6),
              // Adjust opacity for a subtle overlay
              BlendMode.srcOver, // Use a better blending mode
            ),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Top Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () async {
                      // Add functionality for near_me button
                      var weatherData = await weather.getLocationData();
                      updateUI(weatherData);
                    },
                    icon: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  IconButton(
                    onPressed: ()  async {
                      // Add functionality for location_city button
                     var typedName = await  Navigator.push(context, MaterialPageRoute(builder: (context) => CityScreen(),
                     ),
                     );
                     if(typedName!= null){
                       var weatherData = await  weather.getCityWeather(typedName);
                       updateUI(weatherData);
                     }
                     },
                    icon: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              // Temperature and Weather Row
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$weatherTemperature°',
                      style: kTempTextStyle,
                    ),
                    SizedBox(width: 10.0), // Space between text
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              // Weather Message
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $weatherCity',
                  textAlign: TextAlign.right,
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
