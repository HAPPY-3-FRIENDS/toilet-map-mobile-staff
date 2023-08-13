import 'package:json_annotation/json_annotation.dart';

part 'room_status.g.dart';

@JsonSerializable()
class RoomStatus {
  final int numNotAvailableRestroom;
  final int numberOfRestroom;
  final int numNotAvailableBathroom;
  final int numberOfBathroom;
  final int waitingRestroomTime;
  final int waitingBathroomTime;

  const RoomStatus(this.numNotAvailableRestroom, this.numberOfRestroom, this.numNotAvailableBathroom, this.numberOfBathroom, this.waitingRestroomTime, this.waitingBathroomTime);

  factory RoomStatus.fromJson(Map<String, dynamic> json) => _$RoomStatusFromJson(json);
  Map<String, dynamic> toJson() => _$RoomStatusToJson(this);
}