// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Checkin _$CheckinFromJson(Map<String, dynamic> json) => Checkin(
      json['toiletId'] as int?,
      json['userId'] as int?,
      json['serviceType'] as String?,
      json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
    );

Map<String, dynamic> _$CheckinToJson(Checkin instance) => <String, dynamic>{
      'userId': instance.userId,
      'toiletId': instance.toiletId,
      'serviceType': instance.serviceType,
      'dateTime': instance.dateTime?.toIso8601String(),
    };
