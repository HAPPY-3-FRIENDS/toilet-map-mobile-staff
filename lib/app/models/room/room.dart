import 'package:json_annotation/json_annotation.dart';

part 'room.g.dart';

@JsonSerializable()
class Room {
  final int id;
  final int numberOfRestroom;
  final int maxNumberOfRestroom;
  final int numberOfBathroom;
  final int maxNumberOfBathroom;
  final int numberOfDisabledRestroom;
  final int maxNumberOfDisabledRestroom;


  const Room(this.id, this.numberOfRestroom, this.maxNumberOfRestroom, this.numberOfBathroom, this.maxNumberOfBathroom, this.numberOfDisabledRestroom, this.maxNumberOfDisabledRestroom);

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
  Map<String, dynamic> toJson() => _$RoomToJson(this);
}