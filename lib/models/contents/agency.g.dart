// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Agency _$AgencyFromJson(Map<String, dynamic> json) => Agency(
      id: json['id'] as int,
      name: json['name'] as String,
      code: json['code'] as String,
      profile: json['profile'] as String?,
      address: json['address'] as String?,
      department:
          Department.fromJson(json['department'] as Map<String, dynamic>),
      ministry: Ministry.fromJson(json['ministry'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AgencyToJson(Agency instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'profile': instance.profile,
      'address': instance.address,
      'department': instance.department.toJson(),
      'ministry': instance.ministry.toJson(),
    };

Department _$DepartmentFromJson(Map<String, dynamic> json) => Department(
      id: json['id'] as int,
      departmentName: json['department_name'] as String,
      deptReferenceNo: json['dept_reference_no'] as String,
    );

Map<String, dynamic> _$DepartmentToJson(Department instance) =>
    <String, dynamic>{
      'id': instance.id,
      'department_name': instance.departmentName,
      'dept_reference_no': instance.deptReferenceNo,
    };

Ministry _$MinistryFromJson(Map<String, dynamic> json) => Ministry(
      id: json['id'] as int,
      ministryName: json['ministry_name'] as String,
      shortName: json['short_name'] as String?,
      ministryReferenceNo: json['ministry_reference_no'] as String,
    );

Map<String, dynamic> _$MinistryToJson(Ministry instance) => <String, dynamic>{
      'id': instance.id,
      'ministry_name': instance.ministryName,
      'short_name': instance.shortName,
      'ministry_reference_no': instance.ministryReferenceNo,
    };
