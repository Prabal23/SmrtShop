// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MyListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyListModel _$MyListModelFromJson(Map<String, dynamic> json) {
  return MyListModel(
    (json['dpositedProduct'] as List)
        ?.map((e) => e == null
            ? null
            : DpositedProduct.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MyListModelToJson(MyListModel instance) =>
    <String, dynamic>{
      'dpositedProduct': instance.dpositedProduct,
    };

DpositedProduct _$DpositedProductFromJson(Map<String, dynamic> json) {
  return DpositedProduct(
    json['id'],
    json['buyerId'],
    json['sellerId'],
    json['productId'],
    json['totalAmount'],
    json['depositAmount'],
    json['status'],
    json['product'] == null
        ? null
        : Product.fromJson(json['product'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DpositedProductToJson(DpositedProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'buyerId': instance.buyerId,
      'sellerId': instance.sellerId,
      'productId': instance.productId,
      'totalAmount': instance.totalAmount,
      'depositAmount': instance.depositAmount,
      'status': instance.status,
      'product': instance.product,
    };

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    json['id'],
    json['productName'],
    json['price'],
    json['image'],
    json['description'],
    json['product_url'],
    json['offer_promo'],
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'productName': instance.productName,
      'price': instance.price,
      'image': instance.image,
      'description': instance.description,
      'product_url': instance.product_url,
      'offer_promo': instance.offer_promo,
    };
