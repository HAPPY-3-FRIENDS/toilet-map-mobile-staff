import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:toiletmap_staff/app/models/checkin/checkin.dart';

import 'package:http/http.dart' as http;
import 'package:toiletmap_staff/app/repositories/shared_preferences_repository.dart';
import 'package:toiletmap_staff/app/utils/constants.dart';

class CheckinRepository {
  Future postCheckin(userId, serviceType, dateTime) async {
    int? accountId = await SharedPreferencesRepository().getAccountId();
    String? accessToken = await SharedPreferencesRepository().getAccessToken();

    var response = await http.post(
        Uri.parse("${AppDomain.appDomain1}/api/toilets/${accountId}/user/check-in"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
          HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
        },
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
    } else {
      return null;
    }
  }

  Future<int?> postCheckinFake(userId, serviceType, dateTime) async {
    int? accountId = await SharedPreferencesRepository().getAccountId();
    String? accessToken = await SharedPreferencesRepository().getAccessToken();
    print('hihi checkin ' + accountId.toString() + " " + userId.toString() + " " + serviceType + " " + dateTime);
    return 200;
  }
}