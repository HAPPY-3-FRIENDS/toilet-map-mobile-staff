import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:toiletmap_staff/app/models/checkin/checkin.dart';

import 'package:http/http.dart' as http;

class CheckinRepository {
  final String _baseUrl = "https://toilet-map.azurewebsites.net/api/toilets/1/user/check-in";

  Future postCheckin(toiletId, userId, serviceType, dateTime) async {
    var response = await http.post(
        Uri.parse("https://toilet-map.azurewebsites.net/api/toilets/1/user/check-in"),
        headers : {'Content-Type': 'application/json', 'charset': 'utf-8'},
        body:
        jsonEncode({
          "accountId": userId,
          "serviceName": serviceType,
          "datetime": dateTime.toString()
        })
    );
    print('response ne: ' + response.body);
    if (response.statusCode == 200) {
      return 200;
    }else{
      return null;
    }
  }
}