import 'dart:typed_data';

class User {
  String name;
  String email;
  String birthdate;
  String bio;
  Uint8List? image;

  User({
    required this.name,
    required this.email,
    required this.birthdate,
    required this.bio,
    this.image,
  });
}
