import 'package:flutter/material.dart';
import '../services/network.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  final String ctName;
  const LoadingScreen({super.key, required this.ctName});
  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await getCityWeather(widget.ctName);
    print(weatherData);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(locationWeather: weatherData,
          );
        },
      ),
    );
  }

  //method to get Dhaka weather
  Future<dynamic> getCityWeather(String cityName) async {
    final String weatherUrl =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=1e65355a6b4874f9d4c1b47509c2784f&units=metric";
    // "https://api.openweathermap.org/data/2.5/weather?lat=88&lon=88&appid=1e65355a6b4874f9d4c1b47509c2784f&units=metric";
    NetworkHelper networkHelper = NetworkHelper('$weatherUrl');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.09),
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(
          child: SpinKitDoubleBounce(
            color: Colors.white,
            size: 100.0,
          ),
        ),
      ),
    );
  }
}
