import 'package:json_annotation/json_annotation.dart';
part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse {
  dynamic data;
  String? message;
  int status;

  BaseResponse(this.data, this.message, this.status);

  factory BaseResponse.fromJson(Map<String, dynamic> json) => _$BaseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}