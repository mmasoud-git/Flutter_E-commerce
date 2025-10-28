import 'package:dio/dio.dart';
import '../utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: Constants.BASE_URL,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 10),
  ));

  ApiService() {
    // Logging for debug (remove in production)
    _dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));

    // Authorization header (uncomment if you need it)
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString(Constants.PREFS_TOKEN);
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
    ));
  }

  Future<Response<dynamic>> get(String path, {Map<String, dynamic>? queryParameters, Options? options}) {
    return _dio.get(path, queryParameters: queryParameters, options: options);
  }

  Future<Response<dynamic>> post(String path, dynamic data, {Options? options}) {
    return _dio.post(path, data: data, options: options);
  }
}