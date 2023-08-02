import 'package:json_annotation/json_annotation.dart';
part 'agency.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Agency {
  Agency({
    required this.id,
    required this.name,
    required this.code,
    this.profile,
    this.address,
    required this.department,
    required this.ministry,
    
  });

  int id;
  String name;
  String code;
  String? profile;
  String? address;
  Department department;
  Ministry ministry;

  factory Agency.fromJson(Map<String, dynamic> json) => _$AgencyFromJson(json);

  Map<String, dynamic> toJson() => _$AgencyToJson(this);
}


@JsonSerializable(explicitToJson: true)
class Department {
  final int id;
  @JsonKey(name: 'department_name')
  final String departmentName;
  @JsonKey(name: 'dept_reference_no')
  final String deptReferenceNo;

  Department({
    required this.id,
    required this.departmentName,
    required this.deptReferenceNo,
  });

  factory Department.fromJson(Map<String, dynamic> json) =>
      _$DepartmentFromJson(json);
  Map<String, dynamic> toJson() => _$DepartmentToJson(this);
}


@JsonSerializable(explicitToJson: true)
class Ministry {
  final int id;
  @JsonKey(name: 'ministry_name')
  final String ministryName;
  @JsonKey(name: 'short_name')
  String? shortName;
  @JsonKey(name: 'ministry_reference_no')
  final String ministryReferenceNo;

  Ministry({
    required this.id,
    required this.ministryName,
    this.shortName,
    required this.ministryReferenceNo,
  });

  factory Ministry.fromJson(Map<String, dynamic> json) =>
      _$MinistryFromJson(json);
  Map<String, dynamic> toJson() => _$MinistryToJson(this);
}
