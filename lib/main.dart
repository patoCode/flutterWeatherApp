import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(
      MaterialApp(
        title: "Temperatura",
        home: Home(),
      ),
    );

class Home extends StatefulWidget {
  //Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var name;
  var temp;
  var maxtemp;
  var mintemp;
  var description;
  var currently;
  var windSpeed;
  var humidity;

  Future getWeather() async {
    var url = Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=Cochabamba&units=metric&lang=es&appid=5bb7a8a879e2d1f70031de70e986dbbd');
    http.Response response = await http.get(url);
    var result = jsonDecode(response.body);
    setState(() {
      this.name = result['name'];
      this.temp = result['main']['temp'];
      this.description = result['weather'][0]['description'];
      this.currently = result['weather'][0]['main'];
      this.windSpeed = result['wind']['speed'];
      this.humidity = result['main']['humidity'];
      this.maxtemp = result['main']['temp_max'];
      this.mintemp = result['main']['temp_min'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            color: Color(0xFF16425B),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20.0,
                  ),
                  child: ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.temperatureHigh,
                      color: Colors.white,
                    ),
                    title: Text(
                      "MÁXIMA ESPERADA",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Text(
                      maxtemp != null ? maxtemp.toString() : "Loading...",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "HOY EN " +
                        (name != null
                            ? name.toString().toUpperCase()
                            : "Loading..."),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u00B0" : "Loading...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    currently != null ? currently.toString() : "Loading...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Temperature"),
                    trailing: Text(temp != null
                        ? temp.toString() + "\u00B0"
                        : "Loading..."),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("Wheather"),
                    trailing: Text(description != null
                        ? description.toString().toUpperCase()
                        : "Loading..."),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("Humidity"),
                    trailing: Text(
                        humidity != null ? humidity.toString() : "Loading..."),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Wind"),
                    trailing: Text(windSpeed != null
                        ? windSpeed.toString()
                        : "Loading..."),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
