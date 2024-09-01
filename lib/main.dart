import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedme/Routes/AppPage.dart';
import 'package:khedme/Routes/AppRoute.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoute.login,
      getPages: AppPage.pages,
    );
  }
}
