// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomStatus _$RoomStatusFromJson(Map<String, dynamic> json) => RoomStatus(
  json['numNotAvailableRestroom'] as int,
  json['numberOfRestroom'] as int,
  json['numNotAvailableBathroom'] as int,
  json['numberOfBathroom'] as int,
  json['waitingRestroomTime'] as int,
  json['waitingBathroomTime'] as int,
);

Map<String, dynamic> _$RoomStatusToJson(RoomStatus instance) => <String, dynamic>{
  'numNotAvailableRestroom': instance.numNotAvailableRestroom,
  'numberOfRestroom': instance.numberOfRestroom,
  'numNotAvailableBathroom': instance.numNotAvailableBathroom,
  'numberOfBathroom': instance.numberOfBathroom,
  'waitingRestroomTime': instance.waitingRestroomTime,
  'waitingBathroomTime': instance.waitingBathroomTime,
};
