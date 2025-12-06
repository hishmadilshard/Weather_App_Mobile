// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../errors/exceptions.dart';  // Changed from package import to relative import

class ApiClient {
  final http.Client client;

  ApiClient(this.client);

  Future<dynamic> get(String endpoint, {Map<String, String>? params}) async {
    try {
      // For OpenWeatherMap API
      final queryParams = {
        ...?params,
        'appid': 'YOUR_API_KEY', // Replace with your API key
        'units': 'metric',
      };
      
      final uri = Uri.https('api.openweathermap.org', '/data/2.5$endpoint', queryParams);
      
      final response = await client.get(uri);
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 404) {
        throw ServerException(message: 'City not found');
      } else {
        throw ServerException(message: 'Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}