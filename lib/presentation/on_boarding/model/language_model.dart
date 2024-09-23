///TODO: Demo Code, Ui Korar jonno kora hoisilo, eta remove kore abar korte hobe
library;

class LanguageModel {
  List<Languages>? languages;

  LanguageModel({this.languages});

  LanguageModel.fromJson(Map<String, dynamic> json) {
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(Languages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (languages != null) {
      data['languages'] = languages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Languages {
  String? language;
  String? nativeScript;
  String? description;

  Languages({this.language, this.nativeScript, this.description});

  Languages.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    nativeScript = json['native_script'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['language'] = language;
    data['native_script'] = nativeScript;
    data['description'] = description;
    return data;
  }
}
