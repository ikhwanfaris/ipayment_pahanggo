import 'package:json_annotation/json_annotation.dart';
import 'package:flutterbase/models/shared/translatable.dart';
part 'bulletin.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Bulletin {
  Bulletin({
    this.id,
    this.translatables,
    this.displayMode,
    this.createdAt,
    this.imageUrl,
    this.attachmentUrl,
    required this.duration

  });

  int? id;
  List<Translatables>? translatables;
  List<String>? displayMode;
  DateTime? createdAt;
  String? imageUrl;
  dynamic attachmentUrl;
  int duration = 0;

  factory Bulletin.fromJson(Map<String, dynamic> json) => _$BulletinFromJson(json);

  Map<String, dynamic> toJson() => _$BulletinToJson(this);
}
