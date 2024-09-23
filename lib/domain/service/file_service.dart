import 'package:fpdart/fpdart.dart';

abstract class FileService {
   Future<Either<String, String>> saveTextContentToFile(
     String fileContent,
  );

  Future<void> getContentFromTextFile({
    required void Function(String) onContent,
  });
}
