import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:toiletmap_staff/app/repositories/shared_preferences_repository.dart';

import '../models/baseResponse/base_response.dart';
import '../models/toilet/toilet.dart';
import '../utils/constants.dart';


class ToiletRepository {
  Future<Toilet?> getToiletInformation() async {
    int? accountId = await SharedPreferencesRepository().getAccountId();
    String? accessToken = await SharedPreferencesRepository().getAccessToken();

    final response = await http.get(
        Uri.parse('${AppDomain.appDomain1}/api/toilets/${accountId}'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
          HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
        }
    );

    if (response.statusCode == 200) {
      print('hihi toilet info');
      final responseJson = jsonDecode(response.body);
      print(responseJson);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      print(baseResponse.data);
      Toilet toilet = Toilet.fromJson(baseResponse.data);
      return toilet;
    } else {
      print("toilet info get failed");
      return null;
    }
  }

  Future<Toilet?> getNearestToilet() async {
    Toilet? toilet = await ToiletRepository().getToiletInformation();
    double lat = toilet!.latitude;
    double long = toilet!.longitude;
    String? accessToken = await SharedPreferencesRepository().getAccessToken();
    print('Do nearest' + long.toString());

    final response = await http.get(
      Uri.parse('${AppDomain.appDomain1}/api/toilets/nearest-toilet?current-latitude=${lat}&current-longitude=${long}&vehicle=bike'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
        HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
      },
    );

    if (response.statusCode == 200) {
      print('hihi toilets info');
      final responseJson = jsonDecode(response.body);
      print(responseJson);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      print(baseResponse.data);
      Toilet toilet = Toilet.fromJson(baseResponse.data);
      return toilet;
    }

    print("Toilets list get failed");
    return null;
  }
}