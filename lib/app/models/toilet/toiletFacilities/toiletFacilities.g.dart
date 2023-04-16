// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toiletFacilities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ToiletFacilities _$ToiletFacilitiesFromJson(Map<String, dynamic> json) =>
    ToiletFacilities(
      json['facilityName'] as String,
      json['facilityType'] as String,
      json['quantity'] as int,
      json['description'] as String?,
    );

Map<String, dynamic> _$ToiletFacilitiesToJson(ToiletFacilities instance) =>
    <String, dynamic>{
      'facilityName': instance.facilityName,
      'facilityType': instance.facilityType,
      'quantity': instance.quantity,
      'description': instance.description,
    };
