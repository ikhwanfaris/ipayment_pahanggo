// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) => Menu(
      id: json['id'] as int,
      lft: json['lft'] as int?,
      rgt: json['rgt'] as int?,
      depth: json['depth'] as int?,
      parentId: json['parent_id'] as int?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      icon: json['icon'] as String?,
      iconClass: json['icon_class'] as String?,
      translatables: (json['translatables'] as List<dynamic>?)
          ?.map((e) => Translatables.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'id': instance.id,
      'lft': instance.lft,
      'rgt': instance.rgt,
      'depth': instance.depth,
      'parent_id': instance.parentId,
      'name': instance.name,
      'type': instance.type,
      'icon': instance.icon,
      'icon_class': instance.iconClass,
      'translatables': instance.translatables?.map((e) => e.toJson()).toList(),
    };
