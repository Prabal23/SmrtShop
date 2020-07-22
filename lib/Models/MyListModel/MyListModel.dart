import 'package:json_annotation/json_annotation.dart';
part 'MyListModel.g.dart';

@JsonSerializable()
class MyListModel {
  List<DpositedProduct> dpositedProduct;

  MyListModel(this.dpositedProduct);

  factory MyListModel.fromJson(Map<String, dynamic> json) =>
      _$MyListModelFromJson(json);
}

@JsonSerializable()
class DpositedProduct {
  dynamic id;
  dynamic buyerId;
  dynamic sellerId;
  dynamic productId;
  dynamic totalAmount;
  dynamic depositAmount;
  dynamic status;
  Product product;

  DpositedProduct(
      this.id,
      this.buyerId,
      this.sellerId,
      this.productId,
      this.totalAmount,
      this.depositAmount,
      this.status,
      this.product);

  factory DpositedProduct.fromJson(Map<String, dynamic> json) =>
      _$DpositedProductFromJson(json);
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

  Product(this.id, this.productName, this.price, this.image,
      this.description, this.product_url, this.offer_promo);

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
