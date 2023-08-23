class EmailHistory {
  List<String> emailList;

  EmailHistory(this.emailList);

  factory EmailHistory.fromJson(List<dynamic> json) {
    return EmailHistory(List<String>.from(json));
  }
}
