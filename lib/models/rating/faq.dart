// ignore_for_file: non_constant_identifier_names
class Faq {
  int? id;
  int? faq_category_id;
  String? attachment;
  String? link;
  String? created_at;
  String? updated_at;
  GetQuestion? question;
  GetAnswer? answer;
  GetCategory? faq_category;

  Faq(List data,
      {this.id,
      this.faq_category_id,
      this.attachment,
      this.link,
      this.created_at,
      this.updated_at});

  Faq.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    faq_category_id = json['faq_category_id'];
    attachment = json['attachment'];
    link = json['link'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    if (json.containsKey('answer') && json['answer'] != null) {
      answer = GetAnswer.fromJson(json['answer']);
    }
    if (json.containsKey('faq_category') && json['faq_category'] != null) {
      faq_category = GetCategory.fromJson(json['faq_category']);
    }
    if (json.containsKey('question') && json['question'] != null) {
      question = GetQuestion.fromJson(json['question']);
    }
    
  }
}

class GetAnswer {
  int? id;
  String? en;
  String? msMy;

  GetAnswer({
    this.id,
    this.en,
    this.msMy,
  });

  GetAnswer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    en = json['en'] ?? '';
    msMy = json['ms_MY'] ?? '';
    
  }
}

class GetQuestion {
  int? id;
  String? en;
  String? msMy;
  
  

  GetQuestion({
    this.id,
    this.en,
    this.msMy,
    
  });

  GetQuestion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    en = json['en'] ?? '';
    msMy = json['ms_MY'] ?? '';
    
  }
}

class GetCategory {
  int? id;
  String? title;
  List<Translatables>? translatables;

  GetCategory({
    this.id,
    this.title,
    this.translatables,
  });

  GetCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] ?? '';
    if (json.containsKey('translatables')) {
      var translatableList = json['translatables'] as List<dynamic>;
      translatables = translatableList
          .map((item) => Translatables.fromJson(item))
          .toList();
    }
  }
}

class Translatables {
  int? id;
  int? translatableId;
  String? translatableType;
  String? path;
  String? language;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;

  Translatables({
    this.id,
    this.translatableId,
    this.translatableType,
    this.path,
    this.language,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  Translatables.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    translatableId = json['translatable_id'] ?? '';
    translatableType = json['translatable_type'] ?? '';
    path = json['path'] ?? '';
    language = json['language'] ?? '';
    content = json['content'] ?? '';
    createdAt = json['created_at'] != null
        ? DateTime.parse(json['created_at'])
        : null;
    updatedAt = json['updated_at'] != null
        ? DateTime.parse(json['updated_at'])
        : null;
  }
}
