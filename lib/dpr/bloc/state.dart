import 'package:buildcivit_app/dpr/model/daily_progress_report_model.dart';

/// states of daily field report screen
sealed class DailyProgressReportScreenState {}

/// loading state
class DailyProgressReportLoadingState extends DailyProgressReportScreenState {}

/// daily progress report data successfully fetched state
class DailyProgressReportDataSuccessfullyFetchState
    extends DailyProgressReportScreenState {
  final DPRDateWiseItemCountModel dprData;

  DailyProgressReportDataSuccessfullyFetchState({required this.dprData});
}

/// error state
final class DailyProgressReportErrorState
    extends DailyProgressReportScreenListenerState {
  final String error;

  DailyProgressReportErrorState({required this.error});
}

/// listener state of daily field report screen
final class DailyProgressReportScreenListenerState
    extends DailyProgressReportScreenState {}

/// initial state of daily field report screen
class DailyFieldReportScreenInitialState
    extends DailyProgressReportScreenState {}

/// listener state to open bottom model sheet
final class OpenBottomModelSheetState
    extends DailyProgressReportScreenListenerState {
  final bool ischecked;

  OpenBottomModelSheetState({required this.ischecked});
}

/// listener state to select date
final class SelectDateState extends DailyProgressReportScreenListenerState {
  final DateTime selectedDate;
  final String field;

  SelectDateState({required this.selectedDate, required this.field});
}

/// state to open date picker
final class OpenDatePickerState extends DailyProgressReportScreenListenerState {
  final String textfieldName;

  OpenDatePickerState({required this.textfieldName});
}

/// state for toggling checkbox
final class CheckboxToggledState
    extends DailyProgressReportScreenListenerState {
  final bool isChecked;

  CheckboxToggledState({required this.isChecked});
}
