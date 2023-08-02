class AddMember {
  String? firstName;
  String? lastName;

  AddMember({
    this.firstName,
    this.lastName,
  });

  AddMember.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
  }
}
