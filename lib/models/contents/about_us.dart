class AboutUs {
  int? id;
  double? lat;
  double? lng;
  String? phone;
  String? email;
  String? webLink;
  String? fbLink;
  String? twitterLink;
  String? youtubeLink;
  int? status;
  String? createdAt;
  String? updatedAt;
  // List<Translatables>? translatables;

  AboutUs({
      this.id,
      this.lat,
      this.lng,
      this.phone,
      this.email,
      this.webLink,
      this.fbLink,
      this.twitterLink,
      this.youtubeLink,
      this.status,
      this.createdAt,
      this.updatedAt,
      // this.translatables,
      });

  AboutUs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lat = json['lat'];
    lng = json['lng'];
    phone = json['phone'];
    email = json['email'];
    webLink = json['web_link'];
    fbLink = json['fb_link'];
    twitterLink = json['twitter_link'];
    youtubeLink = json['youtube_link'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

// class Translatables {
//   int? id;
//   int? translatableId;
//   String? translatableType;
//   String? path;
//   String? language;
//   String? content;
//   String? createdAt;
//   String? updatedAt;

//   Translatables(
//       {this.id,
//       this.translatableId,
//       this.translatableType,
//       this.path,
//       this.language,
//       this.content,
//       this.createdAt,
//       this.updatedAt});

//   Translatables.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     translatableId = json['translatable_id'];
//     translatableType = json['translatable_type'];
//     path = json['path'];
//     language = json['language'];
//     content = json['content'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['translatable_id'] = this.translatableId;
//     data['translatable_type'] = this.translatableType;
//     data['path'] = this.path;
//     data['language'] = this.language;
//     data['content'] = this.content;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }