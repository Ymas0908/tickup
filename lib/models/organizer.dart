class Organizer {
  final String id;
  final String name;
  final String email;
  final String? role;

  Organizer({
    required this.id,
    required this.name,
    required this.email,
    this.role,
  });

  factory Organizer.fromJson(Map<String, dynamic> json) {
    return Organizer(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      if (role != null) 'role': role,
    };
  }

  Organizer copyWith({
    String? id,
    String? name,
    String? email,
    String? role,
  }) {
    return Organizer(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Organizer && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Organizer{id: $id, name: $name, email: $email, role: $role}';
  }
}
