import 'package:dio/dio.dart';
import 'package:quran_majeed/core/utility/logger_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'dio_client.dart';

class FileDownloader {
  Future<String> downloadFile({
    required String url,
    required String savePath,
    required void Function(int) onProgress,
    CancelToken? cancelToken,
  }) async {
    String directoryPath = await getApplicationDirectoryPath();
    String filePath = "$directoryPath/$savePath";
    return await _downloadWithProgress(
        url: url,
        filePath: filePath,
        onProgress: onProgress,
        cancelToken: cancelToken);
  }

  Future<String> _downloadWithProgress({
    required String url,
    required String filePath,
    required void Function(int) onProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      await DioClient.downloadFile(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            int percentage = ((received / total) * 100).floor();
            onProgress(percentage);
          }
        },
        cancelToken: cancelToken,
      );
      return filePath;
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.cancel) rethrow;
      logErrorStatic("Error downloading file: $e", "FileDownloader");
      rethrow;
    }
  }
}
