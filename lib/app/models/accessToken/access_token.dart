import 'package:json_annotation/json_annotation.dart';
part 'access_token.g.dart';

@JsonSerializable()
class AccessToken {
  String accessToken;
  String tokenType;

  AccessToken(this.accessToken, this.tokenType);

  factory AccessToken.fromJson(Map<String, dynamic> json) => _$AccessTokenFromJson(json);
  Map<String, dynamic> toJson() => _$AccessTokenToJson(this);
}