import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  String baseUrl = 'https://api.jikan.moe/v4';

  Future<dynamic> get({
    String endpoint = '',
  }) async {
    try {
      final url = Uri.parse(baseUrl + endpoint);
      final response = await http.get(url);
      // debugPrint(response.body);
      if (response.statusCode == 400) {
        throw Exception('Bad Request');
      }
      if (response.statusCode == 401) {
        throw Exception('Unauthorised action');
      }
      if (response.statusCode == 404) {
        throw Exception('Data not found');
      }
      if (response.statusCode >= 500) {
        throw Exception('Server Error');
      }
      Map<String, dynamic> data = json.decode(
        response.body,
      );

      final result = {
        'data': data['data'],
        'last_page': null,
        'current_page': null,
      };

      if (data.containsKey('pagination')) {
        if (data['pagination'].containsKey('last_visible_page')) {
          result['last_page'] = data['pagination']['last_visible_page'];
        }
        if (data['pagination'].containsKey('current_page')) {
          result['current_page'] = data['pagination']['current_page'];
        }
      } else {
        print('does not have page');
      }

      return result;
    } catch (err) {
      debugPrint(err.toString());
      throw err.toString();
    }
  }
}
