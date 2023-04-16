import 'package:json_annotation/json_annotation.dart';
import 'package:toiletmap_staff/app/models/toilet/toiletFacilities/toiletFacilities.dart';

part 'toilet.g.dart';

@JsonSerializable()
class Toilet {
  int id;
  String toiletName;
  String address;
  String ward;
  String district;
  String province;
  double latitude;
  double longitude;
  String? nearBy;
  String openTime;
  String closeTime;
  int minPrice;
  int maxPrice;
  List<ToiletFacilities> toiletFacilities;
  List<String> toiletImageSources;
  double ratingStar;
  String username;
  String status;
  bool free;

  Toilet(this.id, this.toiletName, this.address, this.ward, this.district, this.province,
      this.latitude, this.longitude, this.nearBy, this.openTime, this.closeTime,
      this.minPrice, this.maxPrice, this.toiletFacilities, this.toiletImageSources,
      this.ratingStar, this.username, this.status, this.free);

  factory Toilet.fromJson(Map<String, dynamic> json) => _$ToiletFromJson(json);
  Map<String, dynamic> toJson() => _$ToiletToJson(this);
}

