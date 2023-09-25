import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project_using_provider/model/login.dart';
import 'package:project_using_provider/screens/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List datas = [];
  Future<LoginModel> formData(String email, String password) async {
    Map<String, dynamic> formData = {};
    formData['email'] = email;
    formData['password'] = password;
    Dio dio = Dio();
    Response response = await dio
        .post('https://api.storerestapi.com/auth/login', data: formData);
    return LoginModel.fromJson(response.data);
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    emailController.text = "marklyan@gmail.com";
    passwordController.text = "simple_password";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [
              Colors.deepOrange,
              Color.fromARGB(255, 78, 56, 117),
            ],
          ),
        ),
        child: Center(
          child: Container(
            width: 400,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () async {
                          final result = await formData(
                              emailController.text, passwordController.text);

                          if (result.data != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainPage(),
                                ));
                          }
                        },
                        child: Text("Login"))
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
