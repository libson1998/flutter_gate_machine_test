// ignore_for_file: constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_gate/ui/cart/cart_screen.dart';
import 'package:flutter_gate/ui/cart/screen_payment_success.dart';
import 'package:flutter_gate/ui/home/bindings/home_binding.dart';
import 'package:flutter_gate/ui/home/home_screen.dart';
import 'package:flutter_gate/ui/login/bindings/login_binding.dart';
import 'package:flutter_gate/ui/login/login_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => CartScreen(),
      binding: LoginBinding(),
    ),GetPage(
      name: _Paths.SUCCESSSCREEN,
      page: () => PaymentSuccessScreen(),
      binding: LoginBinding(),
    ),
  ];
}
