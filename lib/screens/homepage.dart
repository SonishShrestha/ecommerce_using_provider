import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_using_provider/model/dummy_json_model.dart';
import 'package:project_using_provider/screens/all_products.dart';
import 'package:project_using_provider/screens/single_product_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List categories = [];
  List<Products> cartData = [];

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

  DummyJson? dummyJson;
  String? value;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Project Using Provider'),
            actions: [
              IconButton(
                  onPressed: () {
                    Drawer();
                  },
                  icon: Icon(Icons.shopping_cart))
            ],
          ),
          drawer: Drawer(
            child: Column(
              children: cartData.map((e) {
                return Column(
                  children: [Text(e.title)],
                );
              }).toList(),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categories.map((e) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            value = e;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          height: 30,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          margin: const EdgeInsets.all(20),
                          child: Center(
                            child: Text(
                              e.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                value == null
                    ? AllProducts()
                    : FutureBuilder(
                        future: getByCategoryName(value.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: snapshot.data!.products.map((e) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return SingleProductPage(
                                              id: e.id.toString());
                                        },
                                      ));
                                    },
                                    child: Card(
                                        margin: const EdgeInsets.all(20),
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
                                                  onPressed: () {
                                                    setState(() {
                                                      cartData.add(e);
                                                    });
                                                  },
                                                  child:
                                                      const Text('Add To Cart'))
                                            ]))),
                                  );
                                }).toList(),
                              ),
                            );
                          } else {
                            return const Text("loading...");
                          }
                        },
                      )
              ],
            ),
          )),
    );
  }
}
