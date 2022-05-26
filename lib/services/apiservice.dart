import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const api_key = 'a5b380986bmshb5bb6fe1632ccfdp1b82d4jsn848624f7f9f4';
  static var base_url =
      Uri.parse("https://twinword-emotion-analysis-v1.p.rapidapi.com/analyze/");

  static const Map<String, String> headers = {
    'content-type': 'application/x-www-form-urlencoded',
    'x-rapidapi-host': 'twinword-emotion-analysis-v1.p.rapidapi.com',
    'x-rapidapi-key': 'a5b380986bmshb5bb6fe1632ccfdp1b82d4jsn848624f7f9f4',
    'useQueryString': 'true',
  };

  Future<SentAna> post({@required Map<String, String>? query}) async {
    final response = await http.post(base_url, headers: headers, body: query);

    if (response.statusCode == 200) {
      print('Seccess ' + response.body);
      return SentAna.fromJson(json.decode(response.body));
    } else {
      throw Exception('1.Failed to load json data');
    }
  }
}

class SentAna {
  final String? emotions;

  SentAna({this.emotions});

// ignore: empty_constructor_bodies
  factory SentAna.fromJson(Map<String, dynamic> json) {
    return SentAna(emotions: json['emotions_detected'][0]);
  }
}
