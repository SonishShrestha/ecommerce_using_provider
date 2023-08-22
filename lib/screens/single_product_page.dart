import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project_using_provider/model/single_product.dart';

class SingleProductPage extends StatefulWidget {
  final String id;
  const SingleProductPage({super.key, required this.id});

  @override
  State<SingleProductPage> createState() => _SingleProductPageState();
}

class _SingleProductPageState extends State<SingleProductPage> {
  Future<SingleProduct> singleProduct(String id) async {
    Dio dio = Dio();
    final responseSingleProduct =
        await dio.get("https://dummyjson.com/products/$id");
    final getSingleProduct = SingleProduct.fromJson(responseSingleProduct.data);
    return getSingleProduct;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.heart_broken))
        ]),
        body: FutureBuilder<SingleProduct>(
          future: singleProduct(widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  AspectRatio(
                    aspectRatio: 2 / 1,
                    child: Image.network(
                      snapshot.data!.thumbnail.toString(),
                      fit: BoxFit.fill,
                    ),
                  )
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
