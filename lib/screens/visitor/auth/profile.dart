import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;
  final _formKey = GlobalKey<FormState>();
  File? _imageFile;
  final AuthService _userService = AuthService(); // Adjust this if needed
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  String? _token;
  String? _role; // _role is nullable

  @override
  void initState() {
    super.initState();
    _loadTokenAndUserProfile();
  }

  Future<void> _loadTokenAndUserProfile() async {
    _token = await _storage.read(key: 'token');
    _role = await _storage.read(key: 'role'); 
    if (_token != null) {
      User? profile = await _userService.getUserProfile(_token!);
      setState(() {
        user = profile;
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        // You may want to upload this image to the server here or when saving the profile
      }
    });
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_token != null) {
        bool success = await _userService.updateUserProfile(_token!, user!);
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update profile')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!)
                      : user!.photo.isNotEmpty
                          ? NetworkImage(user!.photo) as ImageProvider
                          : const AssetImage(
                              'assets/images/default_avatar.png'),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: user!.firstName,
                decoration: const InputDecoration(labelText: 'First Name'),
                onSaved: (value) {
                  user = user!.copyWith(firstName: value);
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: user!.lastName,
                decoration: const InputDecoration(labelText: 'Last Name'),
                onSaved: (value) {
                  user = user!.copyWith(lastName: value);
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: user!.email,
                decoration: const InputDecoration(labelText: 'Email'),
                readOnly: true,
              ),
              const SizedBox(height: 20),
              // Add other fields like phone, address, etc.
              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
