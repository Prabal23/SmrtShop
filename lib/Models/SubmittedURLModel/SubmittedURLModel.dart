import 'package:json_annotation/json_annotation.dart';
part 'SubmittedURLModel.g.dart';

@JsonSerializable()
class SubmittedURLModel {
  List<ProductUrl> productUrl;

  SubmittedURLModel(this.productUrl);

  factory SubmittedURLModel.fromJson(Map<String, dynamic> json) =>
      _$SubmittedURLModelFromJson(json);
}

@JsonSerializable()
class ProductUrl {
  dynamic id;
  dynamic url;
  dynamic deal_percentage;
  dynamic promo_code;

  ProductUrl(
      this.id,
      this.url,
      this.deal_percentage,
      this.promo_code);

  factory ProductUrl.fromJson(Map<String, dynamic> json) =>
      _$ProductUrlFromJson(json);
}