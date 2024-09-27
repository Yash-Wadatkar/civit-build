import 'dart:async';
import 'package:buildcivit_app/dpr/repository/create_dpr_repository.dart';
import 'package:buildcivit_app/dpr/repository/dpr_data_list_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'state.dart';
import 'event.dart';

class DailyProgressReportBloc
    extends Bloc<DailyProgressdReportEvent, DailyProgressReportScreenState> {
  final DprDataListRepository repository;
  final CreateDprRepository createDprRepository;
  DailyProgressReportBloc(
      {required this.repository, required this.createDprRepository})
      : super(DailyFieldReportScreenInitialState()) {
    /// event handler to fetch dpr data
    on<FetchDprDataEvent>(fetchDprDataEvent);

    /// event handler to open bottom model sheet
    on<OpenBottomModelSheetEvent>(openBottomModelSheetEvent);

    /// event handler for add dfr button clicked event
    on<AddDFRButtonClickedEvent>(addDFRButtonClickedEvent);

    /// event handler to open date picker
    on<OpenDatePickerEvent>(openDatePickerEvent);

    /// event handler for selecting date event
    on<SelectDateEvent>(selectDateEvent);

    on<ToggleCheckboxEvent>(toggleCheckboxEvent);
  }

  FutureOr<void> openBottomModelSheetEvent(
      OpenBottomModelSheetEvent event, Emitter emit) {
    emit(OpenBottomModelSheetState(ischecked: event.ischecked));
  }

  FutureOr<void> addDFRButtonClickedEvent(
      AddDFRButtonClickedEvent event, Emitter emit) {
    emit(DailyProgressReportLoadingState());
    // try {
    //   final
    // }
    emit(DailyFieldReportScreenInitialState());
  }

  FutureOr<void> selectDateEvent(
      SelectDateEvent event, Emitter<DailyProgressReportScreenState> emit) {
    emit(SelectDateState(
      selectedDate: event.selectedDate,
      field: event.field,
    ));
  }

  FutureOr<void> openDatePickerEvent(
      OpenDatePickerEvent event, Emitter<DailyProgressReportScreenState> emit) {
    emit(OpenDatePickerState(textfieldName: event.textfieldName));
  }

  FutureOr<void> toggleCheckboxEvent(
      ToggleCheckboxEvent event, Emitter<DailyProgressReportScreenState> emit) {
    emit(CheckboxToggledState(isChecked: event.isChecked));
  }

  FutureOr<void> fetchDprDataEvent(FetchDprDataEvent event,
      Emitter<DailyProgressReportScreenState> emit) async {
    emit(DailyProgressReportLoadingState());
    try {
      final result = await repository.getDPRDateWiseItem(projectId: '318');
      if (result.data != null) {
        emit(DailyProgressReportDataSuccessfullyFetchState(
            dprData: result.data!));
      } else {
        emit(DailyProgressReportErrorState(
            error: result.errorMessage ?? 'error occurs'));
      }
    } catch (e) {
      emit(DailyProgressReportErrorState(error: e.toString()));
    }
  }
}
