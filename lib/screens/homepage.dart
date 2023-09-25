import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project_using_provider/Provider/add_to_cart.dart';

import 'package:project_using_provider/model/dummy_json_model.dart';
import 'package:project_using_provider/screens/all_products.dart';
import 'package:project_using_provider/screens/single_product_page.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List categories = [];
  // List<Products> cartData = [];

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

  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getProducts();
    getByCategory();
  }

  DummyJson? dummyJson;
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _drawerKey,
          appBar: AppBar(
            title: const Text('Project Using Provider'),
            actions: [
              IconButton(
                  onPressed: () {
                    _drawerKey.currentState!.openEndDrawer();
                  },
                  icon: const Icon(Icons.shopping_cart))
            ],
          ),
          endDrawer: Drawer(child: Consumer<QuantityIncrementDecrement>(
            builder: (context, value, child) {
              return Column(
                children: value.cartData.map((e) {
                  return Container(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(e.product.images[0]),
                      ),
                      title: Text(e.product.title),
                      subtitle: Consumer<QuantityIncrementDecrement>(
                        builder: (context, quantityIncDec, child) {
                          return Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    if (e.quantity > 1) {
                                      quantityIncDec.decrementQuantity(e);
                                    } else {
                                      quantityIncDec.delete(e.product.id);
                                    }
                                  },
                                  icon: Icon(Icons.remove)),
                              Text(e.quantity.toString()),
                              IconButton(
                                  onPressed: () {
                                    quantityIncDec.incrementQuantity(e);
                                  },
                                  icon: Icon(Icons.add))
                            ],
                          );
                        },
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          )),
          body: SingleChildScrollView(
            child: Consumer<QuantityIncrementDecrement>(
              builder: (context, values, child) {
                return Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: categories.map((e) {
                          return InkWell(
                            onTap: () {
                              values.setValue(e);
                              selectedIndex = categories
                                  .indexWhere((element) => element == e);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: selectedIndex ==
                                          categories.indexWhere(
                                              (element) => element == e)
                                      ? Colors.grey
                                      : null,
                                  border: Border.all(color: Colors.black)),
                              height: 30,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              margin: const EdgeInsets.all(20),
                              child: Center(
                                child: Text(
                                  e.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    values.value == null
                        ? const AllProducts()
                        : FutureBuilder(
                            future: getByCategoryName(values.value.toString()),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Consumer<QuantityIncrementDecrement>(
                                    builder: (context, value, child) {
                                      return Row(
                                        children:
                                            snapshot.data!.products.map((e) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return SingleProductPage(
                                                    id: e.id.toString(),
                                                    name: e.title,
                                                  );
                                                },
                                              ));
                                            },
                                            child: Card(
                                                margin:
                                                    const EdgeInsets.all(20),
                                                elevation: 10,
                                                shadowColor: Colors.black,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                color: Colors.grey,
                                                child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 20),
                                                    child: Column(children: [
                                                      Image.network(
                                                        e.images[0],
                                                        width: 150,
                                                        height: 150,
                                                      ),
                                                      Text(
                                                        e.title,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20),
                                                      ),
                                                      Text(
                                                        e.brand,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                      Text(
                                                        e.category,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                      ),
                                                      Text(
                                                        '${e.price}\$',
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          final data = value
                                                              .cartData
                                                              .where((element) =>
                                                                  element
                                                                      .product
                                                                      .id ==
                                                                  e.id);
                                                          if (data.isEmpty) {
                                                            value.cartData.add(
                                                                AddToCartWithQuantity(
                                                                    quantity: 1,
                                                                    product:
                                                                        e));
                                                          } else {
                                                            data.first
                                                                .quantity++;
                                                          }
                                                        },
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateColor
                                                                    .resolveWith((states) =>
                                                                        Color.fromARGB(
                                                                            255,
                                                                            59,
                                                                            58,
                                                                            58))),
                                                        child: const Text(
                                                          'Add To Cart',
                                                        ),
                                                      )
                                                    ]))),
                                          );
                                        }).toList(),
                                      );
                                    },
                                  ),
                                );
                              } else {
                                return const Text("loading...");
                              }
                            },
                          )
                  ],
                );
              },
            ),
          )),
    );
  }
}
