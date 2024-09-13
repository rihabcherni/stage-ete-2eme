import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/widgets/custom_button.dart';
import 'package:frontend/widgets/custom_text_field.dart';
import 'package:frontend/widgets/header_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:animate_do/animate_do.dart';

import '../../../../widgets/message_popup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    String apiUrl = '$backendUrl/api/auth/login';
    final Map<String, String> data = {
      'email': _emailController.text.trim(),
      'password': _passwordController.text.trim(),
    };
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'},
    );
    setState(() {
      _isLoading = false;
    });
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final token = responseData['token'];
      final user = responseData['user'];
      final role = user['role'];
      final fullName = user['full_name'];
      final email = user['email'];
      final userId = user['userId'];

      await _storage.write(key: 'token', value: token);
      await _storage.write(key: 'role', value: role);
      await _storage.write(key: 'fullName', value: fullName);
      await _storage.write(key: 'email', value: email);
      await _storage.write(key: 'userId', value: userId);
      await _storage.write(key: 'isLoggedIn', value: 'true');

      showDialog(
        context: context,
        builder: (context) {
          loggedLink(role, context);
          return MessagePopup(
            imageAssetPath: "assets/images/account.png",
            title: "Congratulations: Login Successfully",
            text:
                'Welcome $fullName.',
            height: 0.60,
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).pop();
          });
          return const MessagePopup(
            imageAssetPath: "assets/images/account.png",
            title: "Error: Login Failed",
            text: 'Failed to login. Please try again.',
            height: 0.55,
          );
        },
      );
    }
  }

  Future<Null> loggedLink(role, BuildContext context) {
    return Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pop();

      switch (role) {
        case 'administrateur':
          Navigator.of(context).pushNamed('/admin');
          break;
        case 'client':
          Navigator.of(context).pushNamed('/client');
          break;
        case 'conducteur':
          Navigator.of(context).pushNamed('/conducteur');
          break;
        case 'operateur':
          Navigator.of(context).pushNamed('/operateur');
          break;
        default:
          Navigator.of(context).pushNamed('/');
          break;
      }
    });
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
              child: Column(
                children: <Widget>[
                  const HeaderAuth(
                    imageAssetPath: 'assets/images/logo.png',
                    height: 200,
                    title: 'Login',
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(50, 10, 50, 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeInUp(
                          duration: const Duration(milliseconds: 1600),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              CustomTextField(
                                hint: 'Email',
                                controller: _emailController,
                                trailingIcon: Icons.mail,
                              ),
                              const SizedBox(height: 15),
                              CustomTextField(
                                hint: 'Password',
                                controller: _passwordController,
                                obscureText: true,
                                trailingIcon: Icons.lock,
                              ),
                              const SizedBox(height: 5),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('/forgot-password');
                                  },
                                  child: const Text(
                                    'Forgot Password?',
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 7),
                              CustomButton(
                                onTap: _login,
                                isLoading: false,
                                texte: "Login",
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text(
                                    'Not a member?',
                                    style: TextStyle(color: kGrayColor),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed("/inscription");
                                    },
                                    child: const Text(
                                      'SignUp',
                                      style: TextStyle(color: kPrimaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
