import 'package:flutter/material.dart';
import 'package:flutter_gate/controller/auth_controller.dart';
import 'package:flutter_gate/widgets/form_widget.dart';

class AddNumberWidget extends StatelessWidget {
  final AuthController authController;
  final TextEditingController phoneController;

  AddNumberWidget(
      {super.key, required this.authController, required this.phoneController});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 45,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                    child: Text(
                  "+91",
                  style: TextStyle(color: Colors.black, fontSize: 12),
                )),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: FormFieldWidget(
                  passwordObscure: false,
                  isIconVisible: true,
                  onSave: (newValue) => authController.mobile.value = newValue!,
                  onChange: (value) {
                    authController.mobile.value = value;
                  },
                  controller: phoneController,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black.withOpacity(0.4), width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelStyle:
                      const TextStyle(fontSize: 14, color: Color(0xffDBDBDB)),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  iconColor: Colors.black,
                  keyboardType: TextInputType.number,
                  hintText: 'Enter number',
                  hintStyle: const TextStyle(color: Color(0xffDBDBDB)),
                  suffixIconColor: const Color(0xffDBDBDB),
                  child: const SizedBox(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';
                    } else if (!RegExp(r'^\+?[0-9]{10,13}$').hasMatch(value)) {
                      return 'Enter a valid phone number';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              if (_formKey.currentState?.validate() ?? false) {
                authController.verifyPhoneNumber(phoneController.text);
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
                "Send OTP",
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
