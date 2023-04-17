import 'package:json_annotation/json_annotation.dart';
import 'package:toiletmap_staff/app/models/toiletService/service/service.dart';

part 'toilet_service.g.dart';

@JsonSerializable()
class ToiletService {
  final int id;
  final int toiletId;
  final Service service;

  const ToiletService(this.id, this.toiletId, this.service);

  factory ToiletService.fromJson(Map<String, dynamic> json) => _$ToiletServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ToiletServiceToJson(this);
}