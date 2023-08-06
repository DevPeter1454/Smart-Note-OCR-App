// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:smartnote/ui/common/app_colors.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final bool hasValidationMessage;
  final TextInputType? textInputType;

  const CustomTextfield({
    Key? key,
    required this.controller,
    this.isPassword = false,
    this.validator,
    this.hintText,
    this.labelText,
    this.helperText,
    this.hasValidationMessage = false,
    this.textInputType,
  }) : super(key: key);

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool passwordVisibility = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // autovalidateMode: AutovalidateMode.always,
      controller: widget.controller,
      cursorColor: kcMediumGrey,
      obscureText: widget.isPassword == true ? !passwordVisibility : false,
      validator: widget.validator,
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword == true
            ? IconButton(
                onPressed: () {
                  setState(() {
                    passwordVisibility = !passwordVisibility;
                  });
                },
                icon: Icon(
                  passwordVisibility == true
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: kcLightGrey.withOpacity(0.6),
                ),
              )
            : null,
        labelText: widget.labelText,
        labelStyle: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(color: kcMediumGrey),
        hintText: widget.hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: kcMediumGrey),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: kcMediumGrey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xffffffff),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x00000000),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x00000000),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.background,
        contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
      ),
    );
  }
}
