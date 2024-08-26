import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/widgets/custom_text_field.dart';
import 'package:frontend/widgets/header_auth.dart';

class InscriptionPage extends StatefulWidget {
  const InscriptionPage({Key? key}) : super(key: key);

  @override
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedRole = 'client';
  String? _company;
  bool _isLoading = false;

  void _register() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      final User user = User(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        role: _selectedRole,
        company: _selectedRole == 'client' ? _company : null,
        isVerified: false,
        isAccepted: false,
      );

      final message = await _authService.registerUser(user);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));

      if (message == 'User registered successfully') {
        await _storage.write(key: 'email', value: user.email);
        await _storage.write(key: 'role', value: user.role);

        Navigator.pushNamed(
          context,
          '/verify-email',
          arguments: {'email': _emailController.text, 'role': _selectedRole},
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? const Center(
                child: SpinKitFadingCircle(
                  color: kPrimaryColor,
                  size: 50.0,
                ),
              )
            : SingleChildScrollView(
                child: Column(children: <Widget>[
                const HeaderAuth(
                  imageAssetPath: 'assets/images/logo.png',
                  height: 200,
                  title: 'Inscription',
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(50, 10, 50, 5),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                hint: 'FirstName',
                                controller: _firstNameController,
                                trailingIcon: Icons.person,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your first name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
                              CustomTextField(
                                hint: 'LastName',
                                controller: _lastNameController,
                                trailingIcon: Icons.person,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your last name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
                              CustomTextField(
                                hint: 'Email',
                                controller: _emailController,
                                trailingIcon: Icons.email,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                      .hasMatch(value)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
                              DropdownButtonFormField<String>(
                                value: _selectedRole,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedRole = newValue!;
                                    // Clear company field if role changes from 'client'
                                    if (_selectedRole != 'client') {
                                      _company = null;
                                    }
                                  });
                                },
                                items: <String>[
                                  'administrateur',
                                  'client',
                                  'conducteur',
                                  'operateur'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  hintText: 'Select Role',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a role';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
                              if (_selectedRole == 'client') ...[
                                CustomTextField(
                                  hint: 'Company',
                                  controller:
                                      TextEditingController(text: _company),
                                  trailingIcon: Icons.business,
                                  onChanged: (value) {
                                    setState(() {
                                      _company = value;
                                    });
                                  },
                                ),
                                const SizedBox(height: 15),
                              ],
                              CustomTextField(
                                hint: 'Password',
                                controller: _passwordController,
                                trailingIcon: Icons.lock,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  } else if (value.length < 6) {
                                    return 'Password must be at least 6 characters long';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _register,
                                child: const Text('Register'),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                                child: const Text('Go to Login'),
                              ),
                            ],
                          ),
                        ),
                      ]),
                )
              ])));
  }
}
