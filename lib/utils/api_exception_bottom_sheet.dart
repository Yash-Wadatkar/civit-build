import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sizer/sizer.dart';

class ApiExceptionBottomSheet extends StatefulWidget {
  final String displayMessage;
  final Function() onTap;
  const ApiExceptionBottomSheet(
      {super.key, required this.displayMessage, required this.onTap});

  @override
  _ApiExceptionBottomSheetState createState() =>
      _ApiExceptionBottomSheetState();
}

class _ApiExceptionBottomSheetState extends State<ApiExceptionBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.5,
          maxChildSize: 0.9,
          minChildSize: 0.2,
          builder: (BuildContext context, ScrollController scrollController) {
            return SizedBox(
              width: 100.w,
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: Center(
                      child: Text(
                    textAlign: TextAlign.center,
                    widget.displayMessage,
                    // style: CommonTextStyles.poppinsBold(13.spa,
                    //    CustomColours.secondaryColourDark, FontWeight.w800),
                  )),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => widget.onTap(),
                          style: TextButton.styleFrom(
                            //  backgroundColor: CustomColours.primaryColour,
                            foregroundColor: Colors.black,
                            side: BorderSide(
                              //   color: CustomColours.inputFieldBorderBlueColour,
                              width: 1,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: Text(
                            "Understood",
                            style: TextStyle(
                              fontSize: 11.spa,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ]),
            );
          }),
    );
  }
}
