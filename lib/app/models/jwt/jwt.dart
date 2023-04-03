import 'package:json_annotation/json_annotation.dart';
part 'jwt.g.dart';

@JsonSerializable()
class JWT {
  String sub;
  int iat;
  int exp;
  String username;
  String role;

  JWT(this.sub, this.iat, this.exp, this.username, this.role);

  factory JWT.fromJson(Map<String, dynamic> json) => _$JWTFromJson(json);

  Map<String, dynamic> toJson() => _$JWTToJson(this);
}