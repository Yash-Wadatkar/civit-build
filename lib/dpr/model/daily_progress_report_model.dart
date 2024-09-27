// model for daily progress report date wise item count

class DPRDateWiseItemCountModel {
  final bool isSuccess;
  final Data? data;
  final List<String>? errorList;
  final String message;

  DPRDateWiseItemCountModel({
    required this.isSuccess,
    this.data,
    this.errorList,
    required this.message,
  });

  factory DPRDateWiseItemCountModel.fromJson(Map<String, dynamic> json) {
    return DPRDateWiseItemCountModel(
      isSuccess: json['isSuccess'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      errorList: json['errorList'] != null
          ? List<String>.from(json['errorList'])
          : null,
      message: json['message'],
    );
  }
}

/// model for data we are getting from response
class Data {
  final List<ResponseItem> response;

  Data({
    required this.response,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      response: List<ResponseItem>.from(
          json['response'].map((item) => ResponseItem.fromJson(item))),
    );
  }
}

/// model for response
class ResponseItem {
  final int dprid;
  final int dprItemCount;
  final String dprDateFrom;
  final String dprDateTo;
  final String dprName;

  ResponseItem({
    required this.dprid,
    required this.dprItemCount,
    required this.dprDateFrom,
    required this.dprDateTo,
    required this.dprName,
  });

  factory ResponseItem.fromJson(Map<String, dynamic> json) {
    return ResponseItem(
      dprid: json['dprid'],
      dprItemCount: json['dprItemCount'],
      dprDateFrom: json['dprDateFrom'],
      dprDateTo: json['dprDateTo'],
      dprName: json['dprName'],
    );
  }
}
