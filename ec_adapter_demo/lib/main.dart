import 'package:ec_adapter_demo/routers/router.dart';
import 'package:flutter/material.dart';
import 'package:ec_adapter/ec_adapter.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      color: Colors.white,
      title: 'Getx Adapter Demo',
      theme: ThemeData(),
      // home: const MyHomePage(),
      initialRoute: ECRouter.home,
      getPages: ECRouter.getPages(),
    );
  }
}
