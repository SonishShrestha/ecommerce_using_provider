import 'package:flutter/material.dart';
import 'package:project_using_provider/Provider/add_to_cart.dart';
import 'package:project_using_provider/screens/homepage.dart';
import 'package:project_using_provider/screens/loginPage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AddToCart>(
          create: (_) => AddToCart(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "HomePage",
        home: MainPage(),
      ),
    );
  }
}
