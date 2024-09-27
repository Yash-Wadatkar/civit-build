import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:buildcivit_app/utils/api_result.dart';
import 'package:http/http.dart' as http;

class CreateDprRepository {
  /// Method to create a DPR by sending a GET request with date, project ID, and employee ID
  String baseUrl = 'https://mobileservices.opticon360.com/api/DPR/DPRCreate';

  Future<ApiResult> createDpr({
    required String projectId,
    required String employeeId,
    required String dprDate,
  }) async {
    final String url =
        '$baseUrl?ProjectID=$projectId&EmployeeId=$employeeId&DPRDate=$dprDate';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return ApiResult(
          data: jsonResponse,
          statusCode: response.statusCode,
        );
      } else if (response.statusCode == 401) {
        return ApiResult(
          errorMessage: "Unauthorized access. Please log in again.",
          statusCode: response.statusCode,
        );
      } else if (response.statusCode == 400) {
        return ApiResult(
          errorMessage: "Bad request. Please check your input and try again.",
          statusCode: response.statusCode,
        );
      } else {
        return ApiResult(
          errorMessage:
              "Unexpected error occurred. Status code: ${response.statusCode}",
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      return ApiResult(
        errorMessage: "No internet connection. Please check your network.",
        statusCode: 500,
      );
    } on TimeoutException {
      return ApiResult(
        errorMessage: "Request timed out. Please try again later.",
        statusCode: 500,
      );
    } on FormatException {
      return ApiResult(
        errorMessage: "Invalid response format. Please contact support.",
        statusCode: 500,
      );
    } catch (e) {
      return ApiResult(
        errorMessage: "An unexpected error occurred: ${e.toString()}",
        statusCode: 500,
      );
    }
  }
}
