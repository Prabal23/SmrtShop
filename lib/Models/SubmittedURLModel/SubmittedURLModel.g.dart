// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubmittedURLModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmittedURLModel _$SubmittedURLModelFromJson(Map<String, dynamic> json) {
  return SubmittedURLModel(
    (json['productUrl'] as List)
        ?.map((e) =>
            e == null ? null : ProductUrl.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SubmittedURLModelToJson(SubmittedURLModel instance) =>
    <String, dynamic>{
      'productUrl': instance.productUrl,
    };

ProductUrl _$ProductUrlFromJson(Map<String, dynamic> json) {
  return ProductUrl(
    json['id'],
    json['url'],
    json['deal_percentage'],
    json['promo_code'],
  );
}

Map<String, dynamic> _$ProductUrlToJson(ProductUrl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'deal_percentage': instance.deal_percentage,
      'promo_code': instance.promo_code,
    };
