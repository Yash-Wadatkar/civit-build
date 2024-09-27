import 'package:buildcivit_app/const/color_constant.dart';
import 'package:buildcivit_app/const/custom_style_widget.dart';
import 'package:buildcivit_app/const/string_constants.dart';
import 'package:buildcivit_app/dpr/bloc/bloc.dart';
import 'package:buildcivit_app/dpr/bloc/event.dart';
import 'package:buildcivit_app/dpr/bloc/state.dart';
import 'package:buildcivit_app/dpr/custom_widgets/custom_textfield_widget.dart';
import 'package:buildcivit_app/dpr/custom_widgets/daily_progress_report_card_widget.dart';
import 'package:buildcivit_app/dpr/custom_widgets/no_dpr_added_text_widget.dart';
import 'package:buildcivit_app/dpr/repository/create_dpr_repository.dart';
import 'package:buildcivit_app/dpr/repository/dpr_data_list_repository.dart';
import 'package:buildcivit_app/utils/api_exception_bottom_sheet.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class DailyProgressReportScreen extends StatefulWidget {
  const DailyProgressReportScreen({super.key});

  @override
  State<DailyProgressReportScreen> createState() =>
      _DailyProgressReportScreen();
}

class _DailyProgressReportScreen extends State<DailyProgressReportScreen> {
  /// Instance of dpr data list repository class
  late final DprDataListRepository repository;

  late final CreateDprRepository createDprRepository;

  /// Instance of daily field report screen bloc
  late final DailyProgressReportBloc dailyFieldReportScreenBloc;

  /// creating textcontroller for dfr name textfield
  final TextEditingController nameController = TextEditingController();

  /// Creating text controllers to display date in text fields
  final TextEditingController dateController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  DateTime? _selectedDate = null;
  DateTime? _selectedFromDate = null;
  DateTime? _selectedToDate = null;

  final bool _ischecked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    repository = DprDataListRepository();
    createDprRepository = CreateDprRepository();
    dailyFieldReportScreenBloc = DailyProgressReportBloc(
        repository: repository, createDprRepository: createDprRepository);
    dailyFieldReportScreenBloc.add(FetchDprDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: dailyFieldReportScreenBloc,
        buildWhen: (previous, current) =>
            current is! DailyProgressReportScreenListenerState,
        listenWhen: (previous, current) =>
            current is DailyProgressReportScreenListenerState,
        listener: (context, state) {
          if (state is OpenBottomModelSheetState) {
            _showBottomSheet(context, state.ischecked);
          } else if (state is DailyProgressReportErrorState) {
            ApiExceptionBottomSheet(
              displayMessage: state.error,
              onTap: () {},
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case DailyProgressReportLoadingState:
              return Scaffold(
                  appBar: _buildAppBarWidget(),
                  body: const Center(child: CircularProgressIndicator()));

            case DailyProgressReportDataSuccessfullyFetchState:
              final dataSuccessfullyFetchState =
                  state as DailyProgressReportDataSuccessfullyFetchState;
              final data = dataSuccessfullyFetchState.dprData.data;

              if (data == null || data.response.isEmpty) {
                print('inside if');
                return Scaffold(
                  backgroundColor: skyBlueColor,
                  appBar: _buildAppBarWidget(),
                  body: NoDprAddedTextWidget(
                    onpress: () {
                      dailyFieldReportScreenBloc.add(
                          OpenBottomModelSheetEvent(ischecked: _ischecked));
                    },
                  ),
                );
              } else {
                print('inside elsse');
                return Scaffold(
                  backgroundColor: skyBlueColor,
                  appBar: _buildAppBarWidget(),
                  body: ListView.builder(
                    padding: EdgeInsets.all(2.w),
                    itemCount: data.response.length,
                    itemBuilder: (context, index) {
                      //log(initState.dfrDataList!.length.toString());
                      return DailyProgressReportCardWidget(
                        fromDate: data.response[index].dprDateFrom,
                        toDate: data.response[index].dprDateTo,
                        date: data.response[index].dprDateFrom,
                        dprName: data.response[index].dprName,
                        dprId: data.response[index].dprid,
                        dprItemCount: data.response[index].dprItemCount,
                      );
                    },
                  ),
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: blueColor,
                    foregroundColor: Colors.white,
                    child: const Icon(Icons.add),
                    onPressed: () {
                      nameController.clear();
                      dailyFieldReportScreenBloc.add(
                          OpenBottomModelSheetEvent(ischecked: _ischecked));
                    },
                  ),
                );
              }

            default:
              return const Scaffold(
                  body: Center(child: Text('Something went wrong')));
          }
        });
  }

  /// method to show bottom model sheet
  void _showBottomSheet(BuildContext context, bool ischecked) {
    final _formKey = GlobalKey<FormState>();
    showModalBottomSheet(
      shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.zero)),
      backgroundColor: Colors.white,
      showDragHandle: true,
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: false,
      barrierColor: Colors.grey.withOpacity(.9),
      context: context,
      builder: (context) {
        return BlocConsumer(
          bloc: dailyFieldReportScreenBloc,
          listenWhen: (previous, current) =>
              current is DailyProgressReportScreenListenerState,
          listener: (context, state) {
            if (state is OpenDatePickerState) {
              _showDatePicker(state.textfieldName);
            } else if (state is SelectDateState) {
              String formattedDate =
                  state.selectedDate.toLocal().toString().split(' ')[0];
              switch (state.field) {
                case 'date':
                  dateController.text = formattedDate;
                  break;
                case 'fromDate':
                  fromDateController.text = formattedDate;
                  break;
                case 'toDate':
                  toDateController.text = formattedDate;
                  break;
              }
            }
          },
          buildWhen: (previous, current) => current is CheckboxToggledState,
          builder: (context, state) {
            if (state is CheckboxToggledState) {
              ischecked = state.isChecked;
            }
            print('-------------------> form rebuild');
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  /// prevent the overlap of textfield with keyboard
                  ///  viewInsets.bottom gives  how much space the system UI (like the keyboard) is taking up from the bottom of the screen.
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    height: 45.h,
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.h),
                          Text(
                            addDFRText,
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: blueColor),
                          ),
                          SizedBox(height: 1.5.h),

                          /// Widget for custom textfield
                          CustomTextFieldWidget(
                            controller: nameController,
                            textfieldName: 'DFR Name',
                            validator: (value) {
                              print('-------------------> validation rebuild');
                              if (value == null || value.isEmpty) {
                                return 'Please enter a DFR Name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 2.5.h),
                          ischecked
                              ? Row(
                                  children: [
                                    Expanded(
                                      flex: 8,
                                      child: CustomTextFieldWidget(
                                        controller: fromDateController,
                                        textfieldName: 'From',
                                        suffixIcon: Icon(
                                          Icons.calendar_month_outlined,
                                          color: blueColor,
                                        ),
                                        onpress: () {
                                          dailyFieldReportScreenBloc.add(
                                              OpenDatePickerEvent(
                                                  textfieldName: 'fromDate'));
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please select a From date';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const Expanded(flex: 1, child: SizedBox()),
                                    Expanded(
                                      flex: 8,
                                      child: CustomTextFieldWidget(
                                        controller: toDateController,
                                        textfieldName: 'To',
                                        suffixIcon: Icon(
                                          Icons.calendar_month_outlined,
                                          color: blueColor,
                                        ),
                                        onpress: () {
                                          dailyFieldReportScreenBloc.add(
                                              OpenDatePickerEvent(
                                                  textfieldName: 'toDate'));
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please select a To date';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : CustomTextFieldWidget(
                                  controller: ischecked
                                      ? TextEditingController()
                                      : dateController,
                                  textfieldName: 'Date',
                                  suffixIcon: Icon(
                                    Icons.calendar_month_outlined,
                                    color: blueColor,
                                  ),
                                  onpress: () {
                                    dailyFieldReportScreenBloc.add(
                                        OpenDatePickerEvent(
                                            textfieldName: 'date'));
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select a date';
                                    }
                                    return null;
                                  },
                                ),

                          SizedBox(height: 1.5.h),
                          Row(
                            children: [
                              Checkbox(
                                activeColor: blueColor,
                                shape: const ContinuousRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.zero)),
                                value: ischecked,
                                onChanged: (value) {
                                  /// reset the current state of the
                                  _formKey.currentState!.reset();
                                  dailyFieldReportScreenBloc.add(
                                      ToggleCheckboxEvent(isChecked: value!));
                                  if (value) {
                                    /// Clear date when multi-day is selected
                                    dateController.clear();

                                    /// select day value chnage to null
                                    _selectedDate = null;
                                  } else {
                                    /// Clear from/to dates when single day is selected
                                    fromDateController.clear();
                                    toDateController.clear();

                                    /// select day value chnage to null
                                    _selectedFromDate = null;
                                    _selectedToDate = null;
                                  }
                                },
                              ),
                              const Text(
                                  'This log represents progress over multiple days'),
                            ],
                          ),

                          SizedBox(height: 2.5.h),
                          Row(
                            children: [
                              /// cancel button
                              Expanded(
                                flex: 6,
                                child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      shape: const ContinuousRectangleBorder(
                                          borderRadius:
                                              BorderRadius.all(Radius.zero)),
                                      side: BorderSide(
                                          width: 2.0, color: blueColor),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 1.5.h),
                                      child: Text(
                                        cancelText,
                                        overflow: TextOverflow.ellipsis,
                                        style: CustomTextStyle.textStyle(
                                            fontSize: 16.sp,
                                            color: blueColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                              ),

                              const Expanded(flex: 1, child: SizedBox()),

                              /// Add DFR Button
                              Expanded(
                                flex: 6,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStatePropertyAll(blueColor),
                                        shape: const WidgetStatePropertyAll(
                                            ContinuousRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.zero)))),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        // Add validation check
                                        dailyFieldReportScreenBloc.add(
                                          AddDFRButtonClickedEvent(dfrData: []),
                                        );
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 1.5.h),
                                      child: Text(
                                        addDFRText,
                                        overflow: TextOverflow.ellipsis,
                                        style: CustomTextStyle.textStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    )),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(
      () {
        /// clear controllers data and reset the dates when action is complete
        _clearControllersData();
        _resetDates();
      },
    );
  }

  /// method to built appbar
  PreferredSizeWidget _buildAppBarWidget() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 3.w, right: 2.w),
            child: Icon(
              Icons.arrow_back_ios,
              color: blackColor,
              size: 20,
            ),
          ),
          Text(
            dailyFieldReportText,
            overflow: TextOverflow.ellipsis,
            style: CustomTextStyle.textStyle(
                color: appBarTextColor,
                fontSize: 17.sp,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  /// Method to show calendar date picker and pick dates for both single and multi-date selection
  void _showDatePicker(String field) {
    showModalBottomSheet(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero),
      ),
      backgroundColor: Colors.white,
      showDragHandle: true,
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: false,
      barrierColor: Colors.grey.withOpacity(.9),
      context: context,
      builder: (context) {
        return Container(
          height: 35.h,
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                calendarType: CalendarDatePicker2Type.single,
                selectableDayPredicate: (date) {
                  if (field == 'fromDate') {
                    // Disable all dates after the current selected "To" date
                    if (_selectedToDate != null &&
                        date.isAfter(_selectedToDate!)) {
                      return false;
                    }
                  }

                  if (field == 'toDate') {
                    // Disable all dates before the selected "From" date
                    if (_selectedFromDate != null &&
                        date.isBefore(_selectedFromDate!)) {
                      return false;
                    }
                  }

                  return true;
                },
              ),
              value: _getInitialDatesForField(field),
              onValueChanged: (dates) async {
                if (dates.isNotEmpty) {
                  if (field == 'date') {
                    _selectedDate = dates.first;
                    dailyFieldReportScreenBloc.add(
                      SelectDateEvent(_selectedDate!, field),
                    );
                  } else if (field == 'fromDate') {
                    _selectedFromDate = dates.first;
                    dailyFieldReportScreenBloc.add(
                      SelectDateEvent(_selectedFromDate!, field),
                    );

                    // Clear and reset "To" date if it's before the new "From" date
                    if (_selectedToDate != null &&
                        _selectedFromDate!.isAfter(_selectedToDate!)) {
                      _selectedToDate = null;
                      toDateController.clear();
                    }
                  } else if (field == 'toDate') {
                    _selectedToDate = dates.first;
                    dailyFieldReportScreenBloc.add(
                      SelectDateEvent(_selectedToDate!, field),
                    );

                    // Clear and reset "From" date if it's after the new "To" date
                    if (_selectedFromDate != null &&
                        _selectedToDate!.isBefore(_selectedFromDate!)) {
                      _selectedFromDate = null;
                      fromDateController.clear();
                    }
                  }

                  await Future.delayed(const Duration(milliseconds: 400));
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                }
              },
            ),
          ),
        );
      },
    );
  }

  /// Method to get the initial dates for each field
  List<DateTime?> _getInitialDatesForField(String field) {
    switch (field) {
      case 'date':
        return _selectedDate != null ? [_selectedDate!] : [];
      case 'fromDate':
        return _selectedFromDate != null ? [_selectedFromDate!] : [];
      case 'toDate':
        return _selectedToDate != null ? [_selectedToDate!] : [];
      default:
        return [];
    }
  }

  /// method to clear all controllers data
  void _clearControllersData() {
    /// clearing the controllers data on press of cancel button
    dateController.clear();
    nameController.clear();
    toDateController.clear();
    fromDateController.clear();
  }

  /// method to reset the dates
  void _resetDates() {
    /// reset the dates
    _selectedDate = null;
    _selectedFromDate = null;
    _selectedToDate = null;
  }
}
