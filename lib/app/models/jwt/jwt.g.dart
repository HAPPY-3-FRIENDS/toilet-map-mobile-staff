// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jwt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JWT _$JWTFromJson(Map<String, dynamic> json) => JWT(
      json['sub'] as String,
      json['iat'] as int,
      json['exp'] as int,
      json['username'] as String,
      json['role'] as String,
    );

Map<String, dynamic> _$JWTToJson(JWT instance) => <String, dynamic>{
      'sub': instance.sub,
      'iat': instance.iat,
      'exp': instance.exp,
      'username': instance.username,
      'role': instance.role,
    };
