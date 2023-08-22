import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project_using_provider/screens/single_product_page.dart';

import '../model/dummy_json_model.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key});

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  List<Products> listOfProducts = [];

  Future<List<Products>> getProducts() async {
    Dio dio = Dio();
    final response = await dio.get('https://dummyjson.com/products');

    final datas = DummyJson.fromJson(response.data);

    listOfProducts = datas.products;

    return listOfProducts;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Our Products",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
        FutureBuilder<List<Products>>(
          future: getProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: snapshot.data!.map((e) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return SingleProductPage(id: e.id.toString());
                          },
                        ));
                      },
                      child: Card(
                          margin: const EdgeInsets.all(20),
                          elevation: 10,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.grey,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              child: Column(children: [
                                Image.network(
                                  e.images[0],
                                  width: 150,
                                  height: 150,
                                ),
                                Text(
                                  e.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  e.brand,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                  e.category,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  '${e.price}\$',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Add To Cart'))
                              ]))),
                    );
                  }).toList(),
                ),
              );
            } else {
              return const Text("loading...");
            }
          },
        ),
      ],
    );
  }
}
