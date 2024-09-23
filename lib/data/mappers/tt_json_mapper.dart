import 'dart:convert';

TTJsonModel ttJsonModelFromJson(String str) => TTJsonModel.fromJson(json.decode(str));
String ttJsonModelToJson(TTJsonModel data) => json.encode(data.toJson());

class TTJsonModel {
  Map<String, List<TTDbFileModel>> trans;
  Map<String, List<TTDbFileModel>> tafsir;

  TTJsonModel({
    required this.trans,
    required this.tafsir,
  });

  factory TTJsonModel.empty() {
    return TTJsonModel(tafsir: {}, trans: {});
  }

  factory TTJsonModel.fromJson(Map<String, dynamic> json) => TTJsonModel(
        trans: Map.from(json["trans"]).map((k, v) => MapEntry<String, List<TTDbFileModel>>(
            k, List<TTDbFileModel>.from(v.map((x) => TTDbFileModel.fromJson(x))))),
        tafsir: Map.from(json["tafsir"]).map((k, v) => MapEntry<String, List<TTDbFileModel>>(
            k, List<TTDbFileModel>.from(v.map((x) => TTDbFileModel.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "trans":
            Map.from(trans).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))),
        "tafsir":
            Map.from(tafsir).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))),
      };
}

class TTDbFileModel {
  String name;
  String fileName;
  String size;
  String language;
  String languageCode;
  Type type;
  String link;

  TTDbFileModel({
    required this.name,
    required this.fileName,
    required this.size,
    required this.language, // Changed to String
    required this.type,
    required this.link,
    required this.languageCode,
  });

  factory TTDbFileModel.fromJson(Map<String, dynamic> json) => TTDbFileModel(
        name: json["name"],
        fileName: json["file_name"],
        size: json["size"],
        language: json["language"], // Changed from "lang"
        type: typeValues.map[json["type"]]!,
        link: json["link"],
        languageCode: json["language_code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "file_name": fileName,
        "size": size,
        "language": language, // Changed to "language"
        "type": typeValues.reverse[type],
        "link": link,
        "language_code": languageCode,
      };

  Map<String, Object> toMap() {
    return {
      'name': name,
      'file_name': fileName,
      'size': size,
      'language': language, // Directly use the language string
      'type': typeValues.reverse[type]!,
      'link': link,
      'language_code': languageCode,
    };
  }
}

// Adjusted Type and Lang enums are not needed anymore if Lang is directly a string.
// Consider removing or adjusting Lang enum if it's used elsewhere in your code.

enum Type { tafseer, translation }

final typeValues = EnumValues({"tafseer": Type.tafseer, "translation": Type.translation});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
