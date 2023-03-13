import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:toiletmap_staff/app/models/checkin/checkin_model.dart';

import '../network/network_helper.dart';
import '../network/network_service.dart';

import 'package:http/http.dart' as http;

class CheckinRepository {
  final String _baseUrl = "https://toiletmap.azurewebsites.net/api/toilets/1/user-check-in";

  /*Future postCheckin(toiletId, userId, serviceType, dateTime) async {
    final response = await NetworkService.sendRequest(
        requestType: RequestType.post,
        body:
        jsonEncode({
          "userId": userId,
          "serviceName": serviceType,
          "dateTime": dateTime.toIso8601String()
        }),
        url: _baseUrl);

    return NetworkHelper.filterResponse(
        callBack: (json) => {},
        response: response,
        onFailureCallBackWithMessage: (errorType, msg) =>
        throw Exception('An Error has happened. $errorType - $msg'));
  }*/

  Future postCheckin(toiletId, userId, serviceType, dateTime) async {
    var response = await http.post(
        Uri.parse("https://toiletmap.azurewebsites.net/api/toilets/1/user-check-in"),
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