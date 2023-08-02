import 'package:flutter/material.dart';
import 'package:flutterbase/models/users/inbox.dart';

class InboxState extends ValueNotifier<List<ServerInbox>> {
  InboxState(List<ServerInbox> value) : super(value);

  void clear() {
    value = [];
    notifyListeners();
  }

  void add(ServerInbox inbox) {
    bool found = false;
    for (var i = 0; i < value.length; i++) {
      var existing = value[i];
      if (existing.id == inbox.id) {
        value[i] = inbox;
        found = true;
      }
    }
    if (!found) {
      value.insert(0, inbox);
    }
    notifyListeners();
  }

  void updated() {
    notifyListeners();
  }
}
