import 'package:buildcivit_app/dpr/ui/daily_progress_report_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// wrappping material app with sizer widget
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return const MaterialApp(
            debugShowCheckedModeBanner: false,

            /// add item screen
            home: DailyProgressReportScreen());
      },
    );
  }
}
