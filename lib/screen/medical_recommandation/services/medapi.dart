import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/med.dart';

class medapi {
  //get all med records
  Future<List<Med>?> getAllrecords() async {
    var client = http.Client();
    var uri = Uri.parse("http://10.0.2.2:7500/medstore");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return medFromJson(json);
    }
  }

  //add new record
  Future<Med> add_record(
      String drugName,
      String conditionName,
      String rating,
      String dosage,
      String sideEffects,
      String price,
      String precaution1,
      String precaution2,
      String precaution3,
      String precaution4,
      String description,
      String recommended) async {
    var client = http.Client();
    var uri = Uri.parse("http://10.0.2.2:7500/medstore");
    final http.Response response = await client.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'drugName': drugName,
        'conditionName': conditionName,
        'rating': rating,
        'dosage': dosage,
        'sideEffects': sideEffects,
        'price': price,
        'precaution1': precaution1,
        'precaution2': precaution2,
        'precaution3': precaution3,
        'precaution4': precaution4,
        'description': description,
        'recommended': recommended
      }),
    );
    if (response.statusCode == 200) {
      var json = response.body;
      return Med.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to save record');
    }
  }

//update user details
  Future<List<Med>?> filterbydrug(drugName) async {
    var client = http.Client();
    var uri = Uri.parse("http://10.0.2.2:7500/medstore/");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return medFromJson(json);
    }
  }
}
