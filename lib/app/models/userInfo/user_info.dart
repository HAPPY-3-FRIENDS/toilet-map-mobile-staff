import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  final int? accountId;
  final String? fullName;
  final String? defaultPayment;
  final int? accountBalance;
  final int? accountTurn;
  final String? username;

  const UserInfo(this.accountId, this.fullName, this.defaultPayment, this.accountBalance, this.accountTurn, this.username);

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}