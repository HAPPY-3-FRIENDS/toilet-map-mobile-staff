import 'package:json_annotation/json_annotation.dart';
part 'toiletFacilities.g.dart';

@JsonSerializable()
class ToiletFacilities {
  String facilityName;
  String facilityType;
  int quantity;
  String? description;

  ToiletFacilities(this.facilityName, this.facilityType, this.quantity, this.description);

  factory ToiletFacilities.fromJson(Map<String, dynamic> json) => _$ToiletFacilitiesFromJson(json);
  Map<String, dynamic> toJson() => _$ToiletFacilitiesToJson(this);
}