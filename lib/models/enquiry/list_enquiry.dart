// ignore_for_file: non_constant_identifier_names

class Enquiry {
  int? id;
  int? enquiry_category_id;
  int? user_id;
  String? reference_number;
  String? ticket_number;
  String? title;
  String? description;
  String? file;
  String? status;
  int? assigned_to;
  String? reassigned_to;
  String? officer_incharge;
  String? answer;
  String? remark_admin;
  String? remark_user;
  String? created_at;
  String? updated_at;
  GetEnquiryCategory? enquiry_category;

  Enquiry(List data,
      {this.id,
      this.enquiry_category_id,
      this.user_id,
      this.reference_number,
      this.ticket_number,
      this.title,
      this.description,
      this.file,
      this.status,
      this.assigned_to,
      this.reassigned_to,
      this.officer_incharge,
      this.answer,
      this.remark_admin,
      this.remark_user,
      this.created_at,
      this.updated_at});

  Enquiry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enquiry_category_id = json['enquiry_category_id'];
    user_id = json['user_id'];
    reference_number = json['reference_number'];
    ticket_number = json['ticket_number'];
    title = json['title'];
    description = json['description'];
    file = json['file'];
    status = json['status'];
    assigned_to = json['assigned_to'];
    reassigned_to = json['reassigned_to'];
    officer_incharge = json['officer_incharge'];
    answer = json['answer'];
    remark_admin = json['remark_admin'];
    remark_user = json['remark_user'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
     if (json.containsKey('enquiry_category') && json['enquiry_category'] != null) {
      enquiry_category = GetEnquiryCategory.fromJson(json['enquiry_category']);
    }
  }
}

class GetEnquiryCategory {
  int? id;
  String? name;

  GetEnquiryCategory({
    this.id,
    this.name,
  });

  GetEnquiryCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? '';
  }
}