import 'package:json_annotation/json_annotation.dart';

part 'checkin_model.g.dart';

@JsonSerializable(createToJson: false)
class CheckinModel {
  final int? userId;
  final int? toiletId;
  final String? serviceType;
  final DateTime? dateTime;

  const CheckinModel(this.toiletId, this.userId, this.serviceType, this.dateTime);

  factory CheckinModel.fromJson(Map<String, dynamic> json) => _$CheckinModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckinModelToJson(this);
}