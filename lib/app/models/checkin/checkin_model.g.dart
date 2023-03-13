// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckinModel _$CheckinModelFromJson(Map<String, dynamic> json) => CheckinModel(
      json['toiletId'] as int?,
      json['userId'] as int?,
      json['serviceType'] as String?,
      json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
    );

Map<String, dynamic> _$CheckinModelToJson(CheckinModel instance) => <String, dynamic>{
  'toiletId': instance.toiletId,
  'userId': instance.userId,
  'serviceType': instance.serviceType,
  'dateTime': instance.dateTime?.toIso8601String(),
};
