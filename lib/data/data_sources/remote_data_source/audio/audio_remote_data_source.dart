import 'package:dio/dio.dart';
import 'package:quran_majeed/data/data_sources/remote_data_source/network/file_downloader.dart';

class AudioRemoteDataSource {
  final FileDownloader _fileDownloader = FileDownloader();

  Future<String> fetchAndDownloadAudio({
    required String url,
    required String filePath,
    required void Function(int percentage) onProgress,
    CancelToken? cancelToken,
  }) async {
    return await _fileDownloader.downloadFile(
      url: url,
      savePath: filePath,
      onProgress: (int progress) => onProgress(progress),
      cancelToken: cancelToken,
    );
  }
}
