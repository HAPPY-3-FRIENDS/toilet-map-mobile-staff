import 'dart:convert';
import 'dart:io';

import 'package:toiletmap_staff/app/models/toiletService/toilet_service.dart';
import 'package:toiletmap_staff/app/repositories/shared_preferences_repository.dart';

import 'package:http/http.dart' as http;

import '../models/baseResponse/base_response.dart';
import '../utils/constants.dart';

class ToiletServiceRepository {
  Future<List<ToiletService>?> getToiletService() async {
    int? accountId = await SharedPreferencesRepository().getAccountId();
    String? accessToken = await SharedPreferencesRepository().getAccessToken();

    final response = await http.get(
        Uri.parse('${AppDomain.appDomain1}/api/toilet-services?toilet-id=${accountId}'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
          HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
        }
    );

    if (response.statusCode == 200) {
      print("service oke");
      final responseJson = jsonDecode(response.body);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      List<ToiletService> services = (baseResponse.data as List).map(
              (i) => ToiletService.fromJson(i)).toList();
      return services;
    }

    if (response.statusCode == 204) {
      List<ToiletService> services = [];
      return services;
    }

    print("service failed");
    return null;
  }
}