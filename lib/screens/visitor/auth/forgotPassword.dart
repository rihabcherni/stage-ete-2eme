import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/widgets/custom_button.dart';
import 'package:frontend/widgets/custom_text_field.dart';
import 'package:frontend/widgets/header_auth.dart';
import 'package:frontend/utils/constant.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:animate_do/animate_do.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _forgotPassword() async {
    setState(() {
      _isLoading = true;
    });
    String apiUrl = '$backendUrl/api/auth/password-reset/';

    final Map<String, String> data = {
      'email': _emailController.text.trim(),
    };
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    setState(() {
      _isLoading = false;
    });
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final message = responseData['message'];

      showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 5), () {
            Navigator.of(context).pushNamed('/teacher');
          });
          return AlertDialog(
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.72,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage("assets/images/account.png"),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Congratulations',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 20, // Specify your title size here
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Forgot Password Successfully',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16, // Specify your text size here
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        message,
                        style: const TextStyle(
                          fontSize: 16, // Specify your text size here
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SpinKitFadingCircle(
                      color: kPrimaryColor,
                      size: 40.0,
                    )
                  ],
                ),
              ),
            ),
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

          return AlertDialog(
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.53,
              child: const Center(
                child: Column(
                  children: [
                    Image(
                      image: AssetImage("assets/images/account.png"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Forgot Password Failed',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 20, // Specify your title size here
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Failed to forgot password. Please try again.',
                      style: TextStyle(
                        fontSize: 16, // Specify your text size here
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SpinKitFadingCircle(
                      color: kPrimaryColor,
                      size: 40.0,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
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
              child: Column(
                children: <Widget>[
                  const HeaderAuth(
                    imageAssetPath: 'assets/images/forgot-password.png',
                    height: 200,
                    title: 'Forgot Password',
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(50, 10, 50, 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1600),
                          child: Column(
                            children: [
                              const SizedBox(height: 30),
                              CustomTextField(
                                hint: 'Email',
                                controller: _emailController,
                                trailingIcon: Icons.mail,
                              ),
                              const SizedBox(height: 20),
                              CustomButton(
                                onTap: _forgotPassword,
                                isLoading: false,
                                texte: "Forgot password",
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
                                      Navigator.of(context).pushNamed("/login");
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
