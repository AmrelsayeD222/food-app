import 'package:dio/dio.dart';

import '../../constants/constants.dart';
import '../../helper/shared_pref_storage.dart';

class ApiServices {
  final Dio _dio;
  final SharedPrefsService _sharedPrefsService;
  ApiServices(this._dio, this._sharedPrefsService);

  Future<Map<String, String>> _buildHeaders({
    String? contentType,
  }) async {
    final token = await _sharedPrefsService.getToken();
    final headers = <String, String>{
      'Accept': 'application/json',
      if (contentType != null) 'Content-Type': contentType,
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
    return headers;
  }

  Future<Options> _buildOptions({String? contentType}) async {
    final headers = await _buildHeaders(contentType: contentType);
    return Options(headers: headers);
  }

  Future<Map<String, dynamic>> post(
      {required String endPoint, required dynamic data}) async {
    final options = await _buildOptions();
    final response = await _dio.post(
      '$baseUrl$endPoint',
      data: data,
      options: options,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> postFormData({
    required String endPoint,
    required FormData data,
  }) async {
    final options = await _buildOptions(contentType: 'multipart/form-data');
    final response = await _dio.post(
      '$baseUrl$endPoint',
      data: data,
      options: options,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    final options = await _buildOptions();
    final response = await _dio.get(
      '$baseUrl$endPoint',
      options: options,
    );
    return response.data;
  }
}
