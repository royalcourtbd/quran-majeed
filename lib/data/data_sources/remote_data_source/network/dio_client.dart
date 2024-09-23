import 'package:dio/dio.dart';
import 'package:quran_majeed/core/utility/logger_utility.dart';

class DioClient {
  static final Dio _dio = Dio();

  static Dio get instance => _dio;

  // Private constructor
  DioClient._();

  // Optionally, configure Dio globally here
  static void configureDio() {
    _dio.options
      ..baseUrl = 'your_base_url_here' // Set base URL for all requests
      ..connectTimeout =
          const Duration(milliseconds: 5000) // Set connection timeout
      ..receiveTimeout =
          const Duration(milliseconds: 5000); // Set receive timeout

    // Add interceptors if needed
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  // Example of a method to perform a GET request that can be cancelled
  static Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters, CancelToken? cancelToken}) async {
    try {
      final response = await _dio.get(path,
          queryParameters: queryParameters, cancelToken: cancelToken);
      return response;
    } on DioException catch (e) {
      // Handle DioException
      logErrorStatic('Error in GET request: $e', 'DioClient');
      rethrow;
    }
  }

  // Example of a method to perform a POST request that can be cancelled
  static Future<Response> post(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken}) async {
    try {
      final response = await _dio.post(path,
          data: data,
          queryParameters: queryParameters,
          cancelToken: cancelToken);
      return response;
    } on DioException catch (e) {
      // Handle DioException
      logErrorStatic('Error in POST request: $e', 'DioClient');
      rethrow;
    }
  }

  // download file
  static Future<Response> downloadFile(String url, String savePath,
      {CancelToken? cancelToken, ProgressCallback? onReceiveProgress}) async {
    try {
      final response = await _dio.download(url, savePath,
          cancelToken: cancelToken, onReceiveProgress: onReceiveProgress);
      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) rethrow;
      logErrorStatic('Error in download file: $e', 'DioClient');
      rethrow;
    }
  }

  // Download multiple files
  static Future<List<Response>> downloadMultipleFiles(
      List<String> urls, List<String> savePaths,
      {CancelToken? cancelToken, ProgressCallback? onReceiveProgress}) async {
    try {
      final List<Future<Response>> downloadFutures = [];
      for (int i = 0; i < urls.length; i++) {
        downloadFutures.add(_dio.download(urls[i], savePaths[i],
            cancelToken: cancelToken, onReceiveProgress: onReceiveProgress));
      }
      final List<Response> responses = await Future.wait(downloadFutures);
      return responses;
    } on DioException catch (e) {
      // Handle DioException
      logErrorStatic('Error in downloading multiple files: $e', 'DioClient');
      rethrow;
    }
  }
}
