import 'package:flutter/material.dart';
import 'package:project_using_provider/model/dummy_json_model.dart';

class AddToCartWithQuantity {
  int quantity;
  Products product;

  AddToCartWithQuantity({required this.quantity, required this.product});
}

class QuantityIncrementDecrement extends ChangeNotifier {
  List<AddToCartWithQuantity> cartData = [];

  String? _value;
  String? get value => _value;

  void setValue(e) {
    _value = e;
    notifyListeners();
  }

  void incrementQuantity(AddToCartWithQuantity incrementValue) {
    incrementValue.quantity++;
    notifyListeners();
  }

  void decrementQuantity(AddToCartWithQuantity decrementValue) {
    decrementValue.quantity--;
    notifyListeners();
  }

  void delete(int data) {
    cartData.removeWhere((element) => element.product.id == data);
    notifyListeners();
  }
}
