import 'package:flutter/material.dart';
import 'package:flutter_gate/controller/cart_controller.dart';
import 'package:flutter_gate/ui/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PaymentSuccessScreen extends StatelessWidget {
  // Initialize the cartController using Get.lazyPut to avoid issues on widget rebuild
  PaymentSuccessScreen({super.key}) {
    Get.lazyPut(() => CartController());
  }

  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    const TextStyle headingStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.green,
    );

    const TextStyle bodyStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    );

    const TextStyle amountStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.green,
    );

    const TextStyle labelStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    );

    return Scaffold(
      body: Obx(() { // Use Obx to reactively update UI when cartController changes
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset('assets/lottie/payment_success.json'),
            ),
            const SizedBox(height: 24),
            const Text("Payment Success", style: headingStyle),
            const SizedBox(height: 12),
            const Text(
              'We have received your payment successfully',
              style: bodyStyle,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Amount paid ", style: labelStyle),
                Text(
                  "${cartController.totalAmount!.value.toStringAsFixed(2)} INR",
                  style: amountStyle,
                ),
              ],
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(20),
              child: InkWell(
                onTap: () {
                  cartController.clearCart(context).then((value) {
                    Get.offAll(() => HomeScreen());
                  }).catchError((error) {
                    // Handle errors
                    Get.snackbar('Error', 'Failed to clear cart: $error');
                  });
                },
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(24.0)),
                  child: const Center(
                    child: Text(
                      "GO HOME",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
