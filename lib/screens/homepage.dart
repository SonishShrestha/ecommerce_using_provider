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

  Future<List<Products>> getProducts() async {
    Dio dio = Dio();
    final response = await dio.get('https://dummyjson.com/products');
    // Map<String, dynamic> json = jsonDecode(response.data);

    // List<dynamic> datas = json["products"];
    // List<Products> events =
    //     datas.map((dynamic item) => Products.fromJson(item)).toList();
    // return events;

    final datas = DummyJson.fromJson(response.data);

    listOfProducts = datas.products;

    return listOfProducts;
  }

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
    getProducts();
    // getByCategory();
  }

  @override
  Widget build(BuildContext context) {
    // print(categorys);
    return Scaffold(
        appBar: AppBar(
          title: Text('Project Using Provider'),
        ),
        body: FutureBuilder<List<Products>>(
          future: getProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: snapshot.data!.map((e) {
                  return Column(
                    children: [Text(e.title)],
                  );
                }).toList(),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
