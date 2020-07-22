import 'package:json_annotation/json_annotation.dart';
part 'ProductPromoModel.g.dart';

@JsonSerializable()
class ProductPromoModel {
  List<AllOrders> allOrders;

  ProductPromoModel(this.allOrders);

  factory ProductPromoModel.fromJson(Map<String, dynamic> json) =>
      _$ProductPromoModelFromJson(json);
}

@JsonSerializable()
class AllOrders {
  dynamic id;
  dynamic buyerId;
  dynamic sellerId;
  dynamic productId;
  dynamic totalAmount;
  dynamic depositAmount;
  dynamic status;
  Seller seller;
  Productwithpromo productwithpromo;

  AllOrders(
      this.id,
      this.buyerId,
      this.sellerId,
      this.productId,
      this.totalAmount,
      this.depositAmount,
      this.status,
      this.seller,
      this.productwithpromo);

  factory AllOrders.fromJson(Map<String, dynamic> json) =>
      _$AllOrdersFromJson(json);
}

@JsonSerializable()
class Seller {
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic storeUrl;
  dynamic phone;
  dynamic userType;

  Seller(
      this.id, this.name, this.email, this.storeUrl, this.phone, this.userType);

  factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);
}

@JsonSerializable()
class Productwithpromo {
  dynamic id;
  dynamic productName;
  dynamic price;
  dynamic image;
  dynamic description;
  dynamic product_url;
  dynamic offer_promo;

  Productwithpromo(this.id, this.productName, this.price, this.image,
      this.description, this.product_url, this.offer_promo);

  factory Productwithpromo.fromJson(Map<String, dynamic> json) =>
      _$ProductwithpromoFromJson(json);
}
