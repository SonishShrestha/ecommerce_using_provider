import 'package:flutter/material.dart';
import 'package:project_using_provider/model/dummy_json_model.dart';
import 'package:project_using_provider/model/single_product.dart';

class AddToCart extends ChangeNotifier {
  List<Products> cartData = [];

  String? _value;
  String? get value => _value;

  void setValue(e) {
    _value = e;
    notifyListeners();
  }
}

class AddToCartWithQuantity {
  SingleProduct singleProduct;
  int quantity;

  AddToCartWithQuantity(this.singleProduct, this.quantity);
}
