import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:toiletmap_staff/app/repositories/shared_preferences_repository.dart';

import '../models/baseResponse/base_response.dart';
import '../models/room/room.dart';
import '../models/roomStatus/room_status.dart';
import '../utils/constants.dart';


class RoomRepository {
  Future<Room?> getRoomInformation() async {
    int? accountId = await SharedPreferencesRepository().getAccountId();
    String? accessToken = await SharedPreferencesRepository().getAccessToken();

    final response = await http.get(
        Uri.parse('${AppDomain.appDomain1}/api/toilets/capacity/${accountId}'),
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
      Room room = Room.fromJson(baseResponse.data);
      return room;
    } else {
      print("toilet info get failed");
      return null;
    }
  }

  Future<RoomStatus?> getRoomStatusInformation() async {
    int? accountId = await SharedPreferencesRepository().getAccountId();
    String? accessToken = await SharedPreferencesRepository().getAccessToken();

    final response = await http.get(
        Uri.parse('${AppDomain.appDomain1}/api/toilets/current-checkIn/${accountId}'),
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
      RoomStatus room = RoomStatus.fromJson(baseResponse.data);
      return room;
    } else {
      print("toilet info get failed");
      return null;
    }
  }

  Future<Room?> postRoomInformation(id, numberOfRestroom, numberOfBathroom, numberOfDisabledRestroom) async {
    int? accountId = await SharedPreferencesRepository().getAccountId();
    String? accessToken = await SharedPreferencesRepository().getAccessToken();

    var response = await http.post(
        Uri.parse("${AppDomain.appDomain1}/api/toilets/capacity"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
          HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
        },
        body:
        jsonEncode({
          "id": accountId,
          "numberOfRestroom": numberOfRestroom,
          "numberOfBathroom": numberOfBathroom,
          "numberOfDisabledRestroom": numberOfDisabledRestroom
        })
    );
    print('response ne: ' + response.body);
    if (response.statusCode == 200) {
      print('hihi toilet info');
      final responseJson = jsonDecode(response.body);
      print(responseJson);
      BaseResponse baseResponse = BaseResponse.fromJson(responseJson);
      print(baseResponse.data);
      Room room = Room.fromJson(baseResponse.data);
      return room;
    } else {
      print("toilet info get failed");
      return null;
    }
  }

  Future<int> postRoomStatusInformation(numberOfRestroom, numberOfBathroom) async {
    int? accountId = await SharedPreferencesRepository().getAccountId();
    String? accessToken = await SharedPreferencesRepository().getAccessToken();

    var response = await http.put(
        Uri.parse("${AppDomain.appDomain1}/api/toilets/update-available-room"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
          HttpHeaders.authorizationHeader: "Bearer ${accessToken}",
        },
        body:
        jsonEncode({
          "toiletId": accountId,
          "numberOfRestroom": numberOfRestroom,
          "numberOfBathroom": numberOfBathroom
        })
    );
    print('response ne: ' + response.body);
    if (response.statusCode == 200) {
      return 200;
    } else {
      print("toilet info get failed");
      return 0;
    }
  }
}