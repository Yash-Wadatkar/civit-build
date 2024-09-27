import 'package:buildcivit_app/const/color_constant.dart';
import 'package:buildcivit_app/const/custom_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final void Function()? onpress;
  final String textfieldName;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  const CustomTextFieldWidget(
      {super.key,
      required this.textfieldName,
      this.suffixIcon,
      this.onpress,
      required this.controller,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textfieldName,
          style: CustomTextStyle.textStyle(fontSize: 15.sp),
        ),
        SizedBox(height: 1.h),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          controller: controller,
          readOnly: suffixIcon == null ? false : true,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.zero),
                  borderSide:
                      BorderSide(width: 1.2, color: searchBarBorderColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.zero),
                  borderSide:
                      BorderSide(width: 1.2, color: searchBarBorderColor)),
              contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero)),
              suffixIcon: IconButton(
                  onPressed: onpress, icon: suffixIcon ?? const SizedBox())),
        )
      ],
    );
  }
}
