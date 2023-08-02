class Tnc {
  int? translatableId;
  String? translatableType;
  String? path;
  String? language;
  String? content;

  Tnc({
    this.translatableId,
    this.translatableType,
    this.path,
    this.language,
    this.content,
  });

  Tnc.fromJson(Map<String, dynamic> json) {
    translatableId = json['translatabel_id'];
    translatableType = json['translatable_type'];
    path = json['path'];
    language = json['language'];
    content = json['content'];
  }
}