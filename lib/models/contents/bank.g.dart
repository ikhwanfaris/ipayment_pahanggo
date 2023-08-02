// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bank _$BankFromJson(Map<String, dynamic> json) => Bank(
      code: json['code'] as String,
      name: json['name'] as String,
      active: json['active'] as bool,
      browser: json['browser'] as String?,
      iosApplicationId: json['iosApplicationId'] as String?,
      androidApplicationId: json['androidApplicationId'] as String?,
      redirectUrls: (json['redirectUrls'] as List<dynamic>?)
          ?.map((e) => RedirectUrl.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BankToJson(Bank instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'active': instance.active,
      'browser': instance.browser,
      'iosApplicationId': instance.iosApplicationId,
      'androidApplicationId': instance.androidApplicationId,
      'redirectUrls': instance.redirectUrls?.map((e) => e.toJson()).toList(),
    };

RedirectUrl _$RedirectUrlFromJson(Map<String, dynamic> json) => RedirectUrl(
      type: json['type'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$RedirectUrlToJson(RedirectUrl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'url': instance.url,
    };
