import 'package:json_annotation/json_annotation.dart';

import '../room/room.dart';
import '../roomStatus/room_status.dart';

part 'room_all.g.dart';

@JsonSerializable()
class RoomAll {
  final Room room;
  final RoomStatus roomStatus;

  const RoomAll(this.room, this.roomStatus);

  factory RoomAll.fromJson(Map<String, dynamic> json) => _$RoomAllFromJson(json);
  Map<String, dynamic> toJson() => _$RoomAllToJson(this);
}