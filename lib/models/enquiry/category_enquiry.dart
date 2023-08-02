// ignore_for_file: non_constant_identifier_names

class CategoryEnquiry {
  // "id": 1,
  //           "name": "pertanyaan segala berkaitan dengan resit.",
  //           "is_active": 1,
  //           "created_at": "2022-11-21T03:31:28.000000Z",
  //           "updated_at": "2022-11-21T03:31:28.000000Z"
  int? id;
  String? name;
  int? is_reference_number;
  int? is_active;
  String? created_at;
  String? updated_at;

  CategoryEnquiry(List data,
      {this.id,
      this.name,
      this.is_reference_number,
      this.is_active,
      this.created_at,
      this.updated_at});

  CategoryEnquiry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    is_reference_number = json['is_reference_number'];
    is_active = json['is_active'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }
}
