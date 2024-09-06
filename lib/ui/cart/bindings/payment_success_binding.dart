import 'package:flutter_gate/controller/cart_controller.dart';
import 'package:flutter_gate/controller/home_controller.dart';
import 'package:get/get.dart';

class PaymentSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(
      () => CartController(),
    );
  }
}
