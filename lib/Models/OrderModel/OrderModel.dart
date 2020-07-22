import 'package:json_annotation/json_annotation.dart';
part 'OrderModel.g.dart';

@JsonSerializable()
class OrderModel {
  List<AllOrders> allOrders;

  OrderModel(this.allOrders);

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
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
  Product product;

  AllOrders(
      this.id,
      this.buyerId,
      this.sellerId,
      this.productId,
      this.totalAmount,
      this.depositAmount,
      this.status,
      this.seller,
      this.product);

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
class Product {
  dynamic id;
  dynamic productName;
  dynamic price;
  dynamic image;
  dynamic description;
  dynamic product_url;
  dynamic offer_promo;

  Product(this.id, this.productName, this.price, this.image, this.description,
      this.product_url, this.offer_promo);

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}