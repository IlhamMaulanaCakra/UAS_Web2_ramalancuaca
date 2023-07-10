import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  String _city = '';
  String _temperature = '';

  void _showWeather() async {
    String apiKey = 'YOUR_API_KEY';
    String apiUrl =
        'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$_city';

    // Mengirim permintaan HTTP GET ke API cuaca
    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Parsing data JSON dari respons API
      var data = jsonDecode(response.body);

      // Menyimpan suhu cuaca dari data yang diperoleh
      var temperature = data['current']['temp_c'];

      setState(() {
        _temperature = '$temperature °C';
      });
    } else {
      setState(() {
        _temperature = 'Error';
      });
    }
  }

  void _WeatherApp() async {
    String apiKey = 'YOUR_API_KEY';
    String apiUrl =
        'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$_city';

    // Mengirim permintaan HTTP GET ke API cuaca
    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Parsing data JSON dari respons API
      var jsonResponse = json.decode(response.body);

      // Menyimpan suhu cuaca dari data yang diperoleh
      var temperature = jsonResponse['current']['temp_c'];

      setState(() {
        _temperature = '$temperature °C';
      });
    } else {
      setState(() {
        _temperature = 'Error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Enter City'),
              onChanged: (value) {
                setState(() {
                  _city = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _showWeather,
              child: Text('Get Weather'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Temperature: $_temperature',
              style: TextStyle(fontSize: 24.0),
            ),
          ],
        ),
      ),
    );
  }
}
