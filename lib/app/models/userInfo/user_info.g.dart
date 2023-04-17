// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      json['fullName'] as String?,
      json['paymentMethod'] as String?,
      json['balance'] as int?,
      json['turn'] as int?,
      json['username'] as String?,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'fullName': instance.fullName,
      'paymentMethod': instance.paymentMethod,
      'balance': instance.balance,
      'turn': instance.turn,
      'username': instance.username,
    };
