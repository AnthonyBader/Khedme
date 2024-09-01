import 'package:get/get.dart';
import 'package:khedme/Bindings/LoginBinding.dart';
import 'package:khedme/Views/Login.dart';
import 'package:khedme/Routes/AppRoute.dart';

class AppPage {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoute.login,
      page: () => const Login(),
      binding: LoginBinding(),
    ),
  ];
}
