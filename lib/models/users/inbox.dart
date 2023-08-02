import 'package:flutterbase/api/api.dart';

class ServerInbox {
  late int id;
  late String subject;
  late String body;
  late DateTime createdAt;
  late bool isRead = false;

  ServerInbox.fromJson(json) {
    id = json['id'];
    subject = json['subject'];
    body = json['body'];
    isRead = json['is_read'] == 1;
    createdAt = DateTime.parse(json['created_at']);
  }

  Future read() async {
    await api.inbox.read(id);
    isRead = true;
  }
}


//         "id": 8806,
//         "user_id": 89,
//         "subject": "Pertanyaan anda telah berjaya dihantar. Butiran pertanyaan adalah seperti berikut: ",
//         "body": "1. No. Tiket: P000000088, 2. Pertanyaan: dev test title inbox,",
//         "url": "",
//         "parameters": "null",
//         "is_read": 0,
//         "created_at": "2023-02-18T09:52:02.000000Z",
//         "updated_at": "2023-02-18T09:52:02.000000Z"