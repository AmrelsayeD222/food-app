import 'package:dio/dio.dart';

import '../../constants/constants.dart';

class ApiServices {
  final Dio _dio;
  ApiServices(this._dio);
  Future<Map<String, dynamic>> post(
      {required String endPoint, required dynamic data, String? token}) async {
    final response = await _dio.post('$baseUrl$endPoint',
        data: data,
        options: Options(headers: {
          'Accept': 'application/json',
          if (token != null && token.isNotEmpty)
            'Authorization': 'Bearer $token',
        }));
    return response.data;
  }

  Future<Map<String, dynamic>> postFormData({
    required String endPoint,
    required FormData data,
    String? token,
  }) async {
    final response = await _dio.post(
      '$baseUrl$endPoint',
      data: data,
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'multipart/form-data',
          if (token != null && token.isNotEmpty)
            'Authorization': 'Bearer $token',
        },
      ),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> get(
      {required String endPoint, String? token}) async {
    final response = await _dio.get(
      '$baseUrl$endPoint',
      options: Options(
        headers: {
          'Accept': 'application/json',
          if (token != null && token.isNotEmpty)
            'Authorization': 'Bearer $token',
        },
      ),
    );
    return response.data;
  }
}
