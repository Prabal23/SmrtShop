import 'package:json_annotation/json_annotation.dart';
part 'ProductModel.g.dart';

@JsonSerializable()
class ProductModel {
  List<Product> product;

  ProductModel(this.product);

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}

@JsonSerializable()
class Product {
  dynamic id;
  dynamic productName;
  dynamic price;
  dynamic image;
  dynamic description;
  dynamic deposite;
  dynamic sellerId;

  Product(
      this.id,
      this.productName,
      this.price,
      this.image,
      this.description,
      this.deposite,
      this.sellerId);

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}