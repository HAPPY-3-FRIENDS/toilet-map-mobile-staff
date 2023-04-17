import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  final String? fullName;
  final String? paymentMethod;
  final int? balance;
  final int? turn;
  final String? username;

  const UserInfo(this.fullName, this.paymentMethod, this.balance, this.turn, this.username);

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}