// ignore_for_file: non_constant_identifier_names
class FileSettingEnquiry {
  int? id;
  int? file_size;
  List<dynamic>? file_format;
  List<dynamic>? image_format;
  int? required_format;
  int? allow_multiple_upload;
  String? placement;
  String? created_at;
  String? updated_at;

  FileSettingEnquiry(List data,
      {this.id,
      this.file_size,
      this.file_format,
      this.image_format,
      this.required_format,
      this.allow_multiple_upload,
      this.placement,
      this.created_at,
      this.updated_at});

  FileSettingEnquiry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    file_size = json['file_size'];
    file_format = json['file_format'];
    image_format = json['image_format'];
    required_format = json['required_format'];
    allow_multiple_upload = json['allow_multiple_upload'];
    placement = json['placement'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }
}


// "data": [
//     {
//       "id": 4,
//       "file_size": 2,
//       "file_format": [
//         "pdf"
//       ],
//       "image_format": [
//         "jpg",
//         "jpeg",
//         "png"
//       ],
//       "required_format": 0,
//       "allow_multiple_upload": 0,
//       "placement": "Pertanyaan",
//       "created_at": "2023-01-11T02:38:13.000000Z",
//       "updated_at": "2023-01-18T03:05:35.000000Z"
//     }
//   ],
  