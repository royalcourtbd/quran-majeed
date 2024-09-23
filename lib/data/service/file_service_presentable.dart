import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:quran_majeed/core/utility/trial_utility.dart';

import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/domain/service/file_service.dart';

class FileServicePresentable extends FileService {
  FileServicePresentable();

  @override
  Future<Either<String, String>> saveTextContentToFile(
    String fileContent,
  ) async {
    final String? filePath = await catchAndReturnFuture(() async {
      final Uint8List fileContentAsUInt8 = utf8.encode(fileContent);

      final String fileName = _generateBackUpFileName();
      final String? result = await FilePicker.platform.saveFile(
        fileName: fileName,
        type: FileType.custom,
        allowedExtensions: ['txt'],
        bytes: fileContentAsUInt8,
        dialogTitle: "Save the file",
      );

      if (result == null) {
        await showMessage(message: "You probably didn't select any folder.");
        throw Exception("No folder selected.");
      }

      await showMessage(message: "Successfully saved.");
      return result;
    });

    return filePath == null ? left("Failed saving") : right(filePath);
  }

  @override
  Future<void> getContentFromTextFile({
    required void Function(String) onContent,
  }) async {
    await catchFutureOrVoid(() async {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt'],
      );

      if (result == null || result.files.isEmpty) {
        await showMessage(message: "You didn't select any file.");
        throw Exception("No file selected");
      }

      final String filePath = result.files.single.path!;
      final File file = File(filePath);
      final bool fileExists = file.existsSync();
      if (!fileExists) {
        await showMessage(message: "Failed to load the file.");
        throw Exception("File doesn't exist");
      }

      final String fileContent = await file.readAsString();
      if (fileContent.isEmpty) {
        await showMessage(message: "Empty file.");
        throw Exception("Empty text file");
      }

      onContent(fileContent);
    });
  }

  String _generateBackUpFileName() {
    final DateTime currentTime = DateTime.now();
    final String fileName =
        "${currentTime.day}_${currentTime.month}_${currentTime.year}$_fileNameSignature.txt";
    return fileName;
  }

  static const _fileNameSignature = "_ird_quran_majeed_back_up";
}
