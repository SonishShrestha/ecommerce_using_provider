import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project_using_provider/model/dummy_json_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Products> listOfProducts = [];

  List categorys = [];

  // Future<List<Products>> getProducts() async {
  //   Dio dio = Dio();
  //   final response = await dio.get('https://dummyjson.com/products');
  //   final datas = DummyJson.fromJson(response.data);

  //   listOfProducts = datas.products;
  // }

  getByCategory() async {
    Dio dio = Dio();

    final dataByCategory =
        await dio.get("https://dummyjson.com/products/categories");
    categorys = dataByCategory.data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getProducts();
    getByCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Project Using Provider'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: categorys.map((e) {
              return Text(e);
            }).toList(),
          ),
        ));
  }
}
