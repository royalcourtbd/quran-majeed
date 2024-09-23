import 'package:dio/dio.dart';
import 'package:quran_majeed/data/data_sources/remote_data_source/network/file_downloader.dart';

class TranslationAndTafseerRemoteDataSource {
  final FileDownloader _fileDownloader = FileDownloader();

  Future<void> downloadDatabase({
    required String url,
    required String fileName,
    required void Function(int percentage) onProgress,
    required CancelToken cancelToken,
  }) async {
    // Call the downloadFile method from the FileDownloader class
    await _fileDownloader.downloadFile(
      url: url,
      savePath: fileName,
      onProgress: (int percentage) => onProgress(percentage),
      cancelToken: cancelToken,
    );
  }
}
