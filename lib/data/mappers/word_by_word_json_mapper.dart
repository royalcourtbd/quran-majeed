class WbwJsonModel {
  final List<WbwDbFileModel> wordbyword;

  WbwJsonModel({required this.wordbyword});

  factory WbwJsonModel.fromJson(Map<String, dynamic> json) {
    return WbwJsonModel(
      wordbyword: (json['wordbyword'] as List)
          .map((item) => WbwDbFileModel.fromJson(item))
          .toList(),
    );
  }
}

class WbwDbFileModel {
  final String name;
  final String fileName;
  final String size;
  final String lang;
  final String type;
  final String link;

  WbwDbFileModel({
    required this.name,
    required this.fileName,
    required this.size,
    required this.lang,
    required this.type,
    required this.link,
  });

  factory WbwDbFileModel.fromJson(Map<String, dynamic> json) {
    return WbwDbFileModel(
      name: json['name'],
      fileName: json['file_name'],
      size: json['size'],
      lang: json['lang'],
      type: json['type'],
      link: json['link'],
    );
  }
}