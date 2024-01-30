import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeocodingServices {
  static Future<String> getFormattedAddress(double lat, double lng) async {
    try {
      String googleMapApiKey = dotenv.get("GOOGLE_MAP_API_KEY");
      const String baseUrl = 'https://maps.googleapis.com/maps/api/geocode/json';
      String url = '$baseUrl?latlng=$lat,$lng&key=$googleMapApiKey&language=ko';

      final Dio dio = Dio();
      final response = await dio.get(url);
      if (response.data['status'] == "OK") {
        return response.data['results'][0]['formatted_address'];
      } else {
        throw Exception('Status Exception: ${response.data['status']}');
      }
    } catch (error) {
      debugPrint('Error [$error] (getFormattedAddress)');
      return '';
    }
  }
}