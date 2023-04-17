import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:toiletmap_staff/app/models/checkin/checkin.dart';

import 'package:http/http.dart' as http;
import 'package:toiletmap_staff/app/models/userInfo/user_info.dart';
import 'package:toiletmap_staff/app/repositories/shared_preferences_repository.dart';
import 'package:toiletmap_staff/app/utils/constants.dart';

import '../models/baseResponse/base_response.dart';

class CheckinRepository {
  Future<UserInfo?> postCheckin(userId, serviceType, dateTime) async {
    int? accountId = await SharedPreferencesRepository().getAccountId();
    String? accessToken = await SharedPreferencesRepository().getAccessToken();

    var response = await http.post(
        Uri.parse("${AppDomain.appDomain1}/api/check-in/toilets/user"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
          HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
        },
        body:
        jsonEncode({
          "toiletId": accountId,
          "accountId": userId,
          "serviceName": serviceType,
          "datetime": dateTime.toString()
        })
    );
    print('response ne: ' + response.body);
    if (response.statusCode == 201) {
      print('checkin successfully');
      final responseJson = jsonDecode(response.body);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      UserInfo info = UserInfo.fromJson(baseResponse.data);
      return info;
    } else {
      final responseJson = jsonDecode(response.body);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      print("checkin failed! " + baseResponse!.errors[0]!);
      return null;
    }
  }

  Future<UserInfo?> postCheckinWithStaticQR(userId) async {
    int? accountId = await SharedPreferencesRepository().getAccountId();
    String? accessToken = await SharedPreferencesRepository().getAccessToken();

    var response = await http.post(
        Uri.parse("${AppDomain.appDomain1}/api/check-in/toilets/user"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
          HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
        },
        body:
        jsonEncode({
          "toiletId": accountId,
          "accountId": userId,
        })
    );
    print('response ne: ' + response.body);
    if (response.statusCode == 201) {
      print('checkin successfully');
      final responseJson = jsonDecode(response.body);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      UserInfo info = UserInfo.fromJson(baseResponse.data);
      return info;
    } else {
      final responseJson = jsonDecode(response.body);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      print("checkin failed! " + baseResponse!.errors[0]!);
      return null;
    }
  }

  Future<UserInfo?> postCheckinsThreeServices(ser1, quan1, ser2, quan2, ser3, quan3) async {
    int? accountId = await SharedPreferencesRepository().getAccountId();
    String? accessToken = await SharedPreferencesRepository().getAccessToken();

    var response = await http.post(
        Uri.parse("${AppDomain.appDomain1}/api/check-in/toilets/walk-in-guest"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
          HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
        },
        body:
        jsonEncode({
          "toiletId": accountId,
          "checkInRequests": [
            {
              "serviceName": ser1,
              "quantity": quan1
            },
            {
              "serviceName": ser2,
              "quantity": quan2
            },
            {
              "serviceName": ser3,
              "quantity": quan3
            }
          ]
        })
    );
    print('response ne: ' + response.body);
    if (response.statusCode == 201) {
      print('checkin successfully');
      final responseJson = jsonDecode(response.body);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      UserInfo info = UserInfo.fromJson(baseResponse.data[0]);
      return info;
    } else {
      final responseJson = jsonDecode(response.body);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      print("checkin failed! " + baseResponse!.errors[0]!);
      return null;
    }
  }
}