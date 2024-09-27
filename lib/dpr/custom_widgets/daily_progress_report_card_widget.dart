import 'package:buildcivit_app/const/custom_style_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DailyProgressReportCardWidget extends StatelessWidget {
  final String dprName;
  final String? date;
  final String? toDate;
  final String? fromDate;
  final int? dprItemCount;
  final int? dprId;
  const DailyProgressReportCardWidget(
      {super.key,
      required this.dprName,
      required this.date,
      this.toDate,
      required this.fromDate,
      required this.dprItemCount,
      required this.dprId});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        shape: const ContinuousRectangleBorder(),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(3.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: Text(
                      dprName,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyle.textStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Expanded(flex: 3, child: SizedBox()),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: const BoxDecoration(color: Color(0xffb46b26)),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 0.4.h),
                            child: Text(
                              dprItemCount.toString(),
                              style: CustomTextStyle.textStyle(
                                  fontSize: 15.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                  date == null || date!.isEmpty
                      ? '$fromDate to $toDate'
                      : date!,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyle.textStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff8f9091),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
