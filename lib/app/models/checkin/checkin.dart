import 'package:json_annotation/json_annotation.dart';

part 'checkin.g.dart';

@JsonSerializable()
class Checkin {
  final int? userId;
  final int? toiletId;
  final String? serviceType;
  final DateTime? dateTime;

  const Checkin(this.toiletId, this.userId, this.serviceType, this.dateTime);

  factory Checkin.fromJson(Map<String, dynamic> json) => _$CheckinFromJson(json);
  Map<String, dynamic> toJson() => _$CheckinToJson(this);
}