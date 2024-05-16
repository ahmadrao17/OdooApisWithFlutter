
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odoo_api/homescreen.dart';

void main() async {
  // Testservice testservice = Testservice();
  // var result =
  //     await testservice.fetchdata();
  // print("Final Result: $result");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Odoo Apis Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(21, 74, 211, 90),
            tertiaryContainer: const Color.fromRGBO(21, 74, 211, 120)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
