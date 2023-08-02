import 'package:flutterbase/api/barrel/barrel.dart';
import 'package:flutterbase/models/users/inbox.dart';
import 'package:flutterbase/states/app_state.dart';

class ApiInbox extends ApiClient {
  int nextPage = 0;
  int total = 0;

  reset() {
    nextPage = 0;
    total = 0;
  }

  Future fetch() async {
    Map<String, dynamic> params = {};
    params['page'] = nextPage + 1;
    var response =
        await ApiClient.instance.get('/api/inbox', queryParameters: params);

    if (response.data['data']['to'] == null) {
      return;
    }
    if (nextPage < response.data['data']['to']) {
      nextPage = nextPage + 1;
    }
    total = response.data['data']['total'];
    for (var item in response.data['data']['data']) {
      var inbox = ServerInbox.fromJson(item);
      state.value.inboxState.add(inbox);
    }
  }

  Future<ServerInbox> read(int id) async {
    var response =
        await ApiClient.instance.get('/api/inbox/read/' + id.toString());
    return ServerInbox.fromJson(response.data['data']);
  }
}
