// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toilet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Toilet _$ToiletFromJson(Map<String, dynamic> json) => Toilet(
      json['id'] as int,
      json['toiletName'] as String,
      json['address'] as String,
      json['ward'] as String,
      json['district'] as String,
      json['province'] as String,
      (json['latitude'] as num).toDouble(),
      (json['longitude'] as num).toDouble(),
      json['nearBy'] as String?,
      json['openTime'] as String,
      json['closeTime'] as String,
      json['minPrice'] as int,
      json['maxPrice'] as int,
      (json['toiletFacilities'] as List<dynamic>)
          .map((e) => ToiletFacilities.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['toiletImageSources'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      (json['ratingStar'] as num).toDouble(),
      json['free'] as bool,
    );

Map<String, dynamic> _$ToiletToJson(Toilet instance) => <String, dynamic>{
      'id': instance.id,
      'toiletName': instance.toiletName,
      'address': instance.address,
      'ward': instance.ward,
      'district': instance.district,
      'province': instance.province,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'nearBy': instance.nearBy,
      'openTime': instance.openTime,
      'closeTime': instance.closeTime,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
      'toiletFacilities': instance.toiletFacilities,
      'toiletImageSources': instance.toiletImageSources,
      'ratingStar': instance.ratingStar,
      'free': instance.free,
    };
