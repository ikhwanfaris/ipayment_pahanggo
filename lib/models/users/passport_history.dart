class PassportHistory {
  int? id;
  int? userId;
  String? passportNo;
  String? passportEndDate;
  String? reason;

  PassportHistory(List data,{
    this.id,
    this.userId,
    this.passportNo,
    this.passportEndDate,
    this.reason,
  });

  PassportHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    passportNo = json['passport_no'] ?? '';
    passportEndDate = json['passport_end_date'] ?? '';
    reason = json['reason'] ?? '';
  }
}
