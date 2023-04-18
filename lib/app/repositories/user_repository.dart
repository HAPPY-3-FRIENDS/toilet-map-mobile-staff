import 'dart:convert';
import 'dart:io';

import 'package:toiletmap_staff/app/models/userInfo/user_info.dart';
import 'package:toiletmap_staff/app/repositories/shared_preferences_repository.dart';

import 'package:http/http.dart' as http;

import '../models/baseResponse/base_response.dart';
import '../utils/constants.dart';


class UserRepository {
  Future<UserInfo?> getUserInformation(String phone) async {
    int? accountId = await SharedPreferencesRepository().getAccountId();
    String? accessToken = await SharedPreferencesRepository().getAccessToken();

    final response = await http.get(
        Uri.parse('${AppDomain.appDomain1}/api/accounts/user-infos?account-username=${phone}'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
          HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
        }
    );

    if (response.statusCode == 200) {
      print('hihi user info');
      final responseJson = jsonDecode(response.body);
      print(responseJson);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      print(baseResponse.data);
      UserInfo user = UserInfo.fromJson(baseResponse.data);
      return user;
    } else {
      print("user info get failed");
      return null;
    }
  }
}