import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';
import 'user.dart';

class userModel extends ChangeNotifier {
  final ImagePicker imagePicker = ImagePicker();
  User? _user;

  User? get user => _user;

  userModel() {
    loadUserFromPrefs(); // Load on init
  }

  Future<void> imageSelector(ImageSource source) async {
    final XFile? image = await imagePicker.pickImage(source: source);
    if (image != null) {
      final bytes = await image.readAsBytes();
      if (_user != null) {
        _user!.image = bytes;
      }
      notifyListeners();
    }
  }

  void removeImage() {
    if (_user != null) {
      _user!.image = null;
      notifyListeners();
    }
  }

  void updateNameAndBio(String name, String bio) {
    if (_user != null) {
      _user!.name = name;
      _user!.bio = bio;
      saveUserToPrefs();
      notifyListeners();
    }
  }

  Future<void> setUserFromSignup({
    required String name,
    required String email,
    required String birthdate,
  }) async {
    _user = User(
      name: name,
      email: email,
      birthdate: birthdate,
      bio: '',
      image: null,
    );
    await saveUserToPrefs();
    notifyListeners();
  }

  Future<void> saveUserToPrefs() async {
    if (_user == null) return;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', _user!.name);
    prefs.setString('email', _user!.email);
    prefs.setString('birthdate', _user!.birthdate);
    prefs.setString('bio', _user!.bio);
  }

  Future<void> loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name');
    final email = prefs.getString('email');
    final birthdate = prefs.getString('birthdate');
    final bio = prefs.getString('bio') ?? '';

    if (name != null && email != null && birthdate != null) {
      _user = User(
        name: name,
        email: email,
        birthdate: birthdate,
        bio: bio,
        image: null,
      );
      notifyListeners();
    }
  }
}
