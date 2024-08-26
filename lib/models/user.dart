class User {
  String firstName;
  String lastName;
  String email;
  String password;
  String role;
  String phone;
  String address;
  String ville;
  String? company;
  DateTime? dateOfBirth;
  bool isVerified;
  bool isAccepted;
  String photo;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.role,
    this.phone = '',
    this.address = '',
    this.ville = '',
    this.company = '',
    this.dateOfBirth,
    this.isVerified = false,
    this.isAccepted = false,
    this.photo = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'role': role,
      'phone': phone,
      'address': address,
      'ville': ville,
      'company': company,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'is_verified': isVerified,
      'is_accepted': isAccepted,
      'photo': photo,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      ville: json['ville'] ?? '',
      company: json['company'],
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'])
          : null,
      isVerified: json['is_verified'],
      isAccepted: json['is_accepted'],
      photo: json['photo'] ?? '',
    );
  }

  User? copyWith({String? firstName, String? lastName}) {}
}
