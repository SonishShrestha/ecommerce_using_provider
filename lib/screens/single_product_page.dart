import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project_using_provider/model/single_product.dart';

class SingleProductPage extends StatefulWidget {
  final String id;
  final String name;
  const SingleProductPage({super.key, required this.id, required this.name});

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
        appBar: AppBar(title: Text(widget.name), actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.heart_broken))
        ]),
        body: FutureBuilder<SingleProduct>(
          future: singleProduct(widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final snapshotData = snapshot.data!;
              return Column(
                children: [
                  AspectRatio(
                    aspectRatio: 2 / 1,
                    child: Image.network(
                      snapshotData.thumbnail.toString(),
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Price : ${snapshotData.price}\$",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.discount),
                      Text(
                        " ${snapshotData.discountPercentage}%",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    snapshotData.description,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(onPressed: () {}, child: Text("Add to Cart"))
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
