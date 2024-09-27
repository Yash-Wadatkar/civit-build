import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:buildcivit_app/dpr/model/daily_progress_report_model.dart';
import 'package:buildcivit_app/utils/api_result.dart';
import 'package:http/http.dart' as http;

class DprDataListRepository {
  /// method to fetch DPR list items data
  Future<ApiResult<DPRDateWiseItemCountModel>> getDPRDateWiseItem(
      {required String projectId}) async {
    /// API URL
    final String baseUrl =
        'https://mobileservices.opticon360.com/api/DPR/DatewiseItemCount?ProjectID=$projectId';

    /// Authorization token
    const String token =
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbkdlbmVyYXRlSWQiOiIwOTczMjE5Yi0zMjk0LTRiN2UtYTlhNS1jYTQxYjMzMTJkZjgiLCJsb2dpbklkIjoiMTQxIiwibG9naW5OYW1lIjoiY2l2aXRidWlsZHN1cHBvcnRAc29mdHRlY2gtZW5nci5jb20iLCJwZXJzb25JZCI6IjE0MSIsImVtcGxveWVlTmFtZSI6IlNodWJoYW0gQiIsIkRlc2lnbmF0aW9uIjoiSVQgSGVhZCIsIm1vYmlsZU51bWJlciI6Ijk1MjI0NjQ4OTYiLCJlbWFpbElkIjoiY2l2aXRidWlsZHN1cHBvcnRAc29mdHRlY2gtZW5nci5jb20iLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImNpdml0YnVpbGRzdXBwb3J0QHNvZnR0ZWNoLWVuZ3IuY29tIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjpbIlJvbGUxIiwiUm9sZTIiXSwiZXhwIjoxNzI5MTg5NTg3LCJpc3MiOiJodHRwczovL2xvY2FsaG9zdDo0NDMzMiIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjQ0MzMyIn0.lQi8p2nSpv5dxGC8nDKWObHWGXRq9_xdznqoqjI9oDU';

    try {
      /// Making GET request with headers
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'accept': 'text/plain',
          'Authorization': token,
        },
      );

      /// Handling the response
      if (response.statusCode == 200) {
        print(response.body);
        final jsonResponse = jsonDecode(response.body);
        final model = DPRDateWiseItemCountModel.fromJson(jsonResponse);
        return ApiResult(data: model, statusCode: response.statusCode);
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
