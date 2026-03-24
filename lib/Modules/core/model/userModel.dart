class UserModel {
  final String name;
  final String email;
  final String phone;
  final String? imagePath;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    this.imagePath,
  });

  @override
  String toString() {
    return 'UserModel{name: $name, email: $email, phone: $phone, imagePath: $imagePath}';
  }
}
