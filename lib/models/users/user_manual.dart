class UserManual {
	int? id;
	String? name;
	String? filePath;
	String? filePathFileName;
	String? type;
	int? roleId;
	String? description;
	String? version;
	int? isActive;
	int? creatorId;
	String? createdAt;
	String? updatedAt;

	UserManual(List data,{this.id, this.name, this.filePath, this.filePathFileName, this.type, this.roleId, this.description, this.version, this.isActive, this.creatorId, this.createdAt, this.updatedAt});

	UserManual.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		name = json['name'];
		filePath = json['file_path'];
		filePathFileName = json['file_path_file_name'];
		type = json['type'];
		roleId = json['role_id'];
		description = json['description'];
		version = json['version'];
		isActive = json['is_active'];
		creatorId = json['creator_id'];
		createdAt = json['created_at'];
		updatedAt = json['updated_at'];
	}

	// Map<String, dynamic> toJson() {
	// 	final Map<String, dynamic> data = new Map<String, dynamic>();
	// 	data['id'] = this.id;
	// 	data['name'] = this.name;
	// 	data['file_path'] = this.filePath;
	// 	data['file_path_file_name'] = this.filePathFileName;
	// 	data['type'] = this.type;
	// 	data['role_id'] = this.roleId;
	// 	data['description'] = this.description;
	// 	data['version'] = this.version;
	// 	data['is_active'] = this.isActive;
	// 	data['creator_id'] = this.creatorId;
	// 	data['created_at'] = this.createdAt;
	// 	data['updated_at'] = this.updatedAt;
	// 	return data;
	// }
}