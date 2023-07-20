// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Room _$RoomFromJson(Map<String, dynamic> json) => Room(
  json['id'] as int,
  json['numberOfRestroom'] as int,
  json['maxNumberOfRestroom'] as int,
  json['numberOfBathroom'] as int,
  json['maxNumberOfBathroom'] as int,
  json['numberOfDisabledRestroom'] as int,
  json['maxNumberOfDisabledRestroom'] as int,
);

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
  'id': instance.id,
  'numberOfRestroom': instance.numberOfRestroom,
  'maxNumberOfRestroom': instance.maxNumberOfRestroom,
  'numberOfBathroom': instance.numberOfBathroom,
  'maxNumberOfBathroom': instance.maxNumberOfBathroom,
  'numberOfDisabledRestroom': instance.numberOfDisabledRestroom,
  'maxNumberOfDisabledRestroom': instance.maxNumberOfDisabledRestroom,
};
