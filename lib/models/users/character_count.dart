class CharacterCount {
  int? id;
  String? category;
  String? type;
  int characterCount = 0;

  CharacterCount(
    List data, {
    this.id,
    this.category,
    this.type,
    required this.characterCount,
  });

  CharacterCount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'] ?? '';
    type = json['type'] ?? '';
    characterCount = json['character_count'];
  }
}
