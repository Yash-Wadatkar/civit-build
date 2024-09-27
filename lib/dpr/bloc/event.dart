/// events for daily field report screen
sealed class DailyProgressdReportEvent {}

/// event to fetch list of DPR data list
class FetchDprDataEvent extends DailyProgressdReportEvent {}

/// open bottom model sheet event
class OpenBottomModelSheetEvent extends DailyProgressdReportEvent {
  final bool ischecked;

  OpenBottomModelSheetEvent({required this.ischecked});
}

/// add DFR button clicked event
class AddDFRButtonClickedEvent extends DailyProgressdReportEvent {
  // final DfrData dfrData;
  final dfrData;

  AddDFRButtonClickedEvent({required this.dfrData});
}

/// event to select date from the calendar
class SelectDateEvent extends DailyProgressdReportEvent {
  final DateTime selectedDate;
  final String field;

  SelectDateEvent(this.selectedDate, this.field);
}

/// event to open datepicker
class OpenDatePickerEvent extends DailyProgressdReportEvent {
  final String textfieldName;

  OpenDatePickerEvent({required this.textfieldName});
}

/// event to toggle checkbox state
class ToggleCheckboxEvent extends DailyProgressdReportEvent {
  final bool isChecked;

  ToggleCheckboxEvent({required this.isChecked});
}
