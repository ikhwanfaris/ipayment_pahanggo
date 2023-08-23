// ignore_for_file: non_constant_identifier_names

class ChatMessage {
  // "id": 1,
  //           "feedback_id": 3,
  //           "user_id": 2,
  //           "description": "Wasalam, tiket encik masih dalam semakan kami",
  //           "created_at": "2022-12-07T01:55:13.000000Z",
  //           "updated_at": "2022-12-07T01:55:13.000000Z"
  int? id;
  int? user_id;
  String? remark;
  String? file;
  String? created_at;
  String? updated_at;
  GetAdmin? user;
  GetRole? role;

  ChatMessage(
      {required this.id,
      required this.user_id,
      required this.remark,
      this.file,
      required this.created_at,
      this.updated_at});

  ChatMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user_id = json['user_id'];
    remark = json['remark'];
    file = json['file'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    if (json.containsKey('user') && json['user'] != null) {
      user = GetAdmin.fromJson(json['user']);
    }
    if (json.containsKey('user') && json['user']['role'] != null) {
      role = GetRole.fromJson(json['user']['role']);
    }
  }
}

class GetAdmin {
  int? id;
  String? first_name;
  String? last_name;

  GetAdmin({
    this.id,
    this.first_name,
    this.last_name,
  });

  GetAdmin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    first_name = json['first_name'] ?? '';
    last_name = json['last_name'] ?? '';
  }
}

class GetRole {
  String? name;

  GetRole({
    this.name,
  });

  GetRole.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
  }
}
