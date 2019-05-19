import 'package:http/http.dart' as http;
import 'dart:convert';

class Earthquake {
  double mag;
  String place;
  DateTime time;
  String title;

  Earthquake({this.mag, this.place, this.time, this.title});

  factory Earthquake.fromJSON(Map<String, dynamic> json) {
    return Earthquake(
      mag: json['mag'].toDouble(),
      place: json['place'],
      time: DateTime.fromMillisecondsSinceEpoch(json['time']),
      title: json['title']
    );
  }
}

Future<List<Earthquake>> fetchQuakes() async {
  http.Response response = await http.get('https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson');
  if(response.statusCode == 200) {
    List<Map<String, dynamic>> mapQuakes = json.decode(response.body)['features'].cast<Map<String, dynamic>>();
    List<Earthquake> earthquakes = mapQuakes.map((json) {
      return Earthquake.fromJSON(json['properties']);
    }).toList();
    return earthquakes;
  }
  else {
    throw Exception('Something went wrong...');
  }
}