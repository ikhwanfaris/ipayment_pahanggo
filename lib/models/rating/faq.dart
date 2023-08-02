// ignore_for_file: non_constant_identifier_names

import 'dart:core';

class Faq {
  // "id": 1,
  //         "name": "nama iPayment",
  //         "attachment": null,
  //         "link": null,
  //         "is_enabled": 1,
  //         "created_at": "2022-10-26T14:05:33.000000Z",
  //         "updated_at": "2022-10-26T14:05:33.000000Z"

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
  String? msMy;

  GetAnswer({
    this.id,
    this.msMy,
  });

  GetAnswer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    msMy = json['ms_MY'] ??'';
  }
}

class GetQuestion {
  int? id;
  String? msMy;

  GetQuestion({
    this.id,
    this.msMy,
  });

  GetQuestion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    msMy = json['ms_MY'] ??'';
  }
}

class GetCategory {
  int? id;
  String? title;

  GetCategory({
    this.id,
    this.title,
  });

  GetCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] ??'';
  }
}
