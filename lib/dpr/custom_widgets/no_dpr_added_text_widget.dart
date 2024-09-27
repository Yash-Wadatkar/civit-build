import 'package:buildcivit_app/const/color_constant.dart';
import 'package:buildcivit_app/const/custom_style_widget.dart';
import 'package:buildcivit_app/const/image_path.dart';
import 'package:buildcivit_app/const/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NoDprAddedTextWidget extends StatelessWidget {
  final void Function()? onpress;
  const NoDprAddedTextWidget({super.key, this.onpress});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(flex: 2, child: SizedBox()),
            Column(
              children: [
                Image.asset(
                  adminImage,
                  height: 8.h,
                ),
                SizedBox(
                  height: 8.h,
                )
              ],
            ),
            const Expanded(child: SizedBox()),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    noDfrtext,
                    style: CustomTextStyle.textStyle(
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w500,
                        color: navBlueColor),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Text(
                    startAddingDfrText,
                    style: CustomTextStyle.textStyle(),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              foregroundColor:
                                  const WidgetStatePropertyAll(Colors.white),
                              backgroundColor:
                                  WidgetStatePropertyAll(blueColor),
                              shape: const WidgetStatePropertyAll(
                                  ContinuousRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.zero)))),
                          onPressed: onpress,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 1.6.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add,
                                  size: 18,
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: 30.w),
                                  child: Text(
                                    addNewDfrText,
                                    overflow: TextOverflow.ellipsis,
                                    style: CustomTextStyle.textStyle(
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          )),
                    ],
                  )
                ],
              ),
            ),
            const Expanded(flex: 1, child: SizedBox()),
          ],
        )
      ],
    );
  }
}
