import 'package:dio/dio.dart';

import '../../constants/constants.dart';

class ApiServices {
  final Dio _dio;
  ApiServices(this._dio);
  Future<Map<String, dynamic>> post(
      {required String endPoint, required dynamic data}) async {
    final response = await _dio.post('$baseUrl$endPoint',
        data: data, options: Options(headers: {}));
    return response.data;
  }
}
