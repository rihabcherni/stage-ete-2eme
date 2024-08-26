class UserMessage {
  final String userId;
  final String firstName;
  final String lastName;
  final String photo;
  final String role;

  UserMessage({required this.userId, required this.firstName, required this.lastName, required this.photo, required this.role});

  factory UserMessage.fromJson(Map<String, dynamic> json) {
    return UserMessage(
      userId: json['_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      photo: json['photo'],
      role: json['role'],
    );
  }
}
