import 'dart:convert';
import 'dart:io';

import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/accessToken/access_token.dart';
import '../models/baseResponse/base_response.dart';
import '../models/jwt/jwt.dart';
import '../utils/constants.dart';

class AuthRepository {
  Future<AccessToken?> authLogin(String username, String password) async {
   /* String hashPassword = BCrypt.hashpw(password, BCrypt.gensalt());

    print('hashPassword: ' + hashPassword);
    BCrypt.
    print(BCrypt.checkpw(password, "\$2a\$10\$4uC1cx1vwiuZKgRtuQqyd.CaYVXPzyWlyJGXalk5EMKmg/tpUbGv2"));
*/
    final response = await http.post(
        Uri.parse('${AppDomain.appDomain1}/api/auth'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
        },
        body:
        jsonEncode({
          "username": username,
          "password": password,
        })
    );
    if(response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      AccessToken accessToken = AccessToken.fromJson(baseResponse.data);
      decodeJWT(accessToken.accessToken);
      return accessToken;
    } else {
      print('ko thanh cong');
      return null;
    }
  }

  Future decodeJWT(String accessToken) async {
    Map<String, dynamic> load = Jwt.parseJwt(accessToken);
    JWT jwt = JWT.fromJson(load);

    print('decode done' + jwt.username + jwt.sub);

    print("sub " + jwt.sub);
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("accessToken", accessToken);
    sharedPreferences.setInt("accountId", (int.parse(jwt.sub)));
  }
}