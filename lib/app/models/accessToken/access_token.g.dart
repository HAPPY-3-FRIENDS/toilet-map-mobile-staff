// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessToken _$AccessTokenFromJson(Map<String, dynamic> json) => AccessToken(
      json['accessToken'] as String,
      json['tokenType'] as String,
    );

Map<String, dynamic> _$AccessTokenToJson(AccessToken instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'tokenType': instance.tokenType,
    };
