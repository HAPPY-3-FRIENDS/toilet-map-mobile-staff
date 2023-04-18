import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:toiletmap_staff/app/repositories/shared_preferences_repository.dart';

import '../models/baseResponse/base_response.dart';
import '../utils/constants.dart';


class PaymentRepository {
  Future<int?> postPayment(accountId, total) async {
    String? accessToken = await SharedPreferencesRepository().getAccessToken();

    print("Này là JSON nè: "+ jsonEncode({
      "accountId": accountId,
      "total": total,
      "method": "Tiền mặt"
    }));

    var response = await http.post(
        Uri.parse("${AppDomain.appDomain1}/api/payments"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
          HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
        },
        body:
        jsonEncode({
          "accountId": accountId,
          "total": total,
          "method": "Tiền mặt"
        })
    );
    print('response ne: ' + response.body);
    if (response.statusCode == 201) {
      return 201;
    } else {
      return null;
    }
  }
}