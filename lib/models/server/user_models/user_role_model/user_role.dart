class UserRole {
  String? id;
  String role;
  String description;

  UserRole({this.id, required this.role, required this.description});

  factory UserRole.fromJson(Map<String, dynamic> json, {String? id}) {
    return UserRole(
      id: id,
      role: json['role'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': role,
      'description': description,
    };
  }
}
