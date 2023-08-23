class CharacterCount {
  int? id;
  String? category;
  String? type;
  String? code;
  int? citizenship;
  int? characterCount = 0;
  int? hasExpiredDate = 0;
  String? mask;

  CharacterCount({
    this.id,
    this.category,
    this.type,
    this.code,
    this.citizenship,
    required this.characterCount,
    this.hasExpiredDate,
    this.mask,
  });

  CharacterCount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'] ?? '';
    type = json['type'] ?? '';
    code = json['code'] ?? '';
    citizenship = json['cizenship'] ?? 0;
    characterCount = json['character_count'] ?? 0;
    hasExpiredDate = json['has_expired_date'] ?? 0;
    mask = json['mask'] ?? '';
    
  }
}
