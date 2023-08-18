import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_using_provider/model/dummy_json_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Products> listOfProducts = [];

  List categories = [];

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

  Future<void> getByCategory() async {
    Dio dio = Dio();

    final dataByCategory =
        await dio.get("https://dummyjson.com/products/categories");

    setState(() {
      categories = dataByCategory.data;
    });
  }

  Future<DummyJson> getByCategoryName(String category) async {
    Dio dio = Dio();

    final responseDataByCategoryName =
        await dio.get('https://dummyjson.com/products/category/${category}');
    final getDataByCategoryName =
        DummyJson.fromJson(responseDataByCategoryName.data);
    return getDataByCategoryName;
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
    print(categories);
    return Scaffold(
        appBar: AppBar(
          title: Text('Project Using Provider'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: categories.map((e) {
                  return Column(
                    children: [
                      Text(e.toString()),
                      FutureBuilder(
                        future: getByCategoryName(e.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: snapshot.data!.products.map((e) {
                                  return Card(
                                      margin: EdgeInsets.all(20),
                                      elevation: 10,
                                      shadowColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
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
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              e.brand,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            Text(
                                              e.category,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                            Text(
                                              '${e.price}\$',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                            ElevatedButton(
                                                onPressed: () {},
                                                child: Text('Add To Cart'))
                                          ])));
                                }).toList(),
                              ),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      )
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ));
  }
}

// FutureBuilder<List<Products>>(
//           future: getProducts(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return Column(
//                 children: snapshot.data!.map((e) {
//                   return Column(
//                     children: [Text(e.title)],
//                   );
//                 }).toList(),
//               );
//             } else {
//               return CircularProgressIndicator();
//             }
//           },
//         )