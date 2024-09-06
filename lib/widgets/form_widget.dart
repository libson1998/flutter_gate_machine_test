import 'package:flutter/material.dart';

class FormFieldWidget extends StatelessWidget {
  final bool passwordObscure;
  final String hintText;
  final bool isIconVisible;
  final String? Function(String?)? validator;
  final void Function(String)? onChange;
  final void Function(String?)? onSave;
  final void Function()? onTap;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? contentPadding;
  final Color? iconColor;
  final Widget child;
  final int? maxLine;
  final String? initialValue;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final int? maxLength;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final TextStyle? hintStyle;
final Color?suffixIconColor;
  const FormFieldWidget({
    Key? key,
    required this.passwordObscure,
    required this.hintText,
    required this.isIconVisible,
    this.validator,
    required this.onChange,
    required this.onSave,
    required this.focusedBorder,
    required this.enabledBorder,
    required this.labelStyle,
    required this.contentPadding,
    this.iconColor = Colors.transparent,
    required this.child,
    this.maxLine = 1,
    this.initialValue,
    this.keyboardType,
    this.controller,
    this.onTap,
    this.prefixIcon,
    this.maxLength,
    required this.errorBorder,
    this.focusedErrorBorder,
    this.hintStyle, this.suffixIconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 50,
        ),
        child: TextFormField(
          maxLength: maxLength,
          controller: controller,
          initialValue: initialValue,
          maxLines: maxLine,
          style: Theme.of(context).inputDecorationTheme.hintStyle,
          obscureText: passwordObscure,
          decoration: InputDecoration(
            focusedBorder: focusedBorder,
            enabledBorder: enabledBorder,
            errorBorder: errorBorder,
            hintText: hintText,
            hintStyle: hintStyle,
            labelStyle: labelStyle,
            contentPadding: contentPadding,
            prefixIcon: prefixIcon,
            suffixIcon: Visibility(visible: isIconVisible, child: child),
            suffixIconColor:suffixIconColor ,
            focusedErrorBorder: focusedErrorBorder,
          ),
          validator: validator,
          onChanged: onChange,
          onSaved: onSave,
          keyboardType: keyboardType,
          onTap: onTap,
        ));
  }
}
