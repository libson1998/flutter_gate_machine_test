import 'package:flutter/material.dart';
import 'package:flutter_gate/controller/auth_controller.dart';
import 'package:flutter_gate/ui/login/widgets/add_number_widget.dart';
import 'package:flutter_gate/ui/login/widgets/add_otp_widget.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthController authController = Get.put(AuthController());
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: const Text('Flutter Gate',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
        ),
        body: SafeArea(child: Obx(() {
          if (authController.isLoading.value) {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            );
          }

          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/login.jpg"),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        if (!authController.isPhoneNumberEntry.value &&
                            !authController.isOtpSent.value &&
                            !authController.isPhoneAuthenticated.value)
                          authController.isLoading.value
                              ? Container(
                                  height: 50,
                                  width: double.maxFinite,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Center(
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    authController.signInWithGoogle();
                                  },
                                  child: Container(
                                    height: 50,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/google.png",
                                          height: 35,
                                          width: 35,
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'Continue with Google',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        const SizedBox(height: 16),
                        if (authController.isPhoneNumberEntry.value &&
                            !authController.isOtpSent.value &&
                            !authController.isPhoneAuthenticated.value)
                          AddNumberWidget(
                              authController: authController,
                              phoneController: phoneController),
                        if (authController.isOtpSent.value &&
                            !authController.isPhoneAuthenticated.value)
                          AddOtpWidget(
                              authController: authController,
                              otpController: otpController),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        })));
  }
}
