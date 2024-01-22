import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoundedTextFieldWithIcon extends StatelessWidget {
  final String hintText;
  final String prefixIconPath;
  final String suffixIconPath;

  final TextEditingController controller;
  final bool isEnable;
  final validator;

  RoundedTextFieldWithIcon(
      {required this.hintText,
      required this.prefixIconPath,
      required this.controller,
      required this.isEnable,
      required this.suffixIconPath,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        validator: validator,
        enabled: isEnable,
        controller: controller,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white,
            ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          fillColor: Theme.of(context).colorScheme.primaryContainer,
          filled: true,
          contentPadding:
              EdgeInsets.symmetric(vertical: 21.h, horizontal: 13.w),
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.white,
              ),
          prefixIcon: prefixIconPath != ""
              ? Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: SvgPicture.asset(
                    prefixIconPath,
                  ),
                )
              : null,
          suffixIcon: suffixIconPath != ""
              ? Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: SvgPicture.asset(
                    suffixIconPath.toString(),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
