class IdentityType {
  int? id;
  String? category;
  String? type;
  int characterCount = 0;
  int hasExpiredDate = 0;

  IdentityType(
    List data, {
    this.id,
    this.category,
    this.type,
    required this.characterCount,
    required this.hasExpiredDate,
  });

  IdentityType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'] ?? '';
    type = json['type'] ?? '';
    characterCount = json['character_count'];
    hasExpiredDate = json['has_expired_date'];
  }
}
