import 'package:flutter/material.dart';
import 'package:flutter_gate/controller/auth_controller.dart';
import 'package:flutter_gate/widgets/form_widget.dart';

class AddOtpWidget extends StatelessWidget {
  final AuthController authController;
  final TextEditingController otpController;

  AddOtpWidget(
      {super.key, required this.authController, required this.otpController});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FormFieldWidget(
            passwordObscure: false,
            isIconVisible: true,
            onSave: (newValue) => authController.otp.value = newValue!,
            onChange: (value) {
              authController.otp.value = value;
            },
            controller: otpController,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.black.withOpacity(0.4), width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            labelStyle: const TextStyle(fontSize: 14, color: Color(0xffDBDBDB)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            iconColor: Colors.black,
            keyboardType: TextInputType.number,
            hintText: 'Enter OTP',
            hintStyle: const TextStyle(color: Color(0xffDBDBDB)),
            suffixIconColor: const Color(0xffDBDBDB),
            child: const SizedBox(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the OTP';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
        InkWell(
            onTap: () {
              if (_formKey.currentState?.validate() ?? false) {
                authController.signInWithOTP(otpController.text);
              }
            },
            child: Container(
              height: 45,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                  child: Text(
                "Verify OTP",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
