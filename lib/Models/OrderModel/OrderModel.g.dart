// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return OrderModel(
    (json['allOrders'] as List)
        ?.map((e) =>
            e == null ? null : AllOrders.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'allOrders': instance.allOrders,
    };

AllOrders _$AllOrdersFromJson(Map<String, dynamic> json) {
  return AllOrders(
    json['id'],
    json['buyerId'],
    json['sellerId'],
    json['productId'],
    json['totalAmount'],
    json['depositAmount'],
    json['status'],
    json['seller'] == null
        ? null
        : Seller.fromJson(json['seller'] as Map<String, dynamic>),
    json['product'] == null
        ? null
        : Product.fromJson(json['product'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AllOrdersToJson(AllOrders instance) => <String, dynamic>{
      'id': instance.id,
      'buyerId': instance.buyerId,
      'sellerId': instance.sellerId,
      'productId': instance.productId,
      'totalAmount': instance.totalAmount,
      'depositAmount': instance.depositAmount,
      'status': instance.status,
      'seller': instance.seller,
      'product': instance.product,
    };

Seller _$SellerFromJson(Map<String, dynamic> json) {
  return Seller(
    json['id'],
    json['name'],
    json['email'],
    json['storeUrl'],
    json['phone'],
    json['userType'],
  );
}

Map<String, dynamic> _$SellerToJson(Seller instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'storeUrl': instance.storeUrl,
      'phone': instance.phone,
      'userType': instance.userType,
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
