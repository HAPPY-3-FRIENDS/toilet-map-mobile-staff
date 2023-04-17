// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toilet_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToiletService _$ToiletServiceFromJson(Map<String, dynamic> json) =>
    ToiletService(
      json['id'] as int,
      json['toiletId'] as int,
      Service.fromJson(json['service'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ToiletServiceToJson(ToiletService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'toiletId': instance.toiletId,
      'service': instance.service,
    };
