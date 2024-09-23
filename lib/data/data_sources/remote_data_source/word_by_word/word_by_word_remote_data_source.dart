import 'package:dio/dio.dart';
import 'package:quran_majeed/data/data_sources/remote_data_source/network/file_downloader.dart';

class WbwRemoteDataSource {
  final FileDownloader _fileDownloader = FileDownloader();

  Future<void> downloadWbwDatabase({
    required String url,
    required String fileName,
    required void Function(int percentage) onProgress,
    required CancelToken cancelToken,
  }) async {
    await _fileDownloader.downloadFile(
      url: url,
      savePath: fileName,
      onProgress: onProgress,
      cancelToken: cancelToken,
    );
  }
}
