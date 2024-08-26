import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/widgets/header_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:animate_do/animate_do.dart';
import '../../../utils/constant.dart';
import '../../../widgets/message_popup.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String email;
  final String role;

  const VerifyEmailScreen({Key? key, required this.email, required this.role})
      : super(key: key);

  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool _isLoading = false;

  Future<void> _verifyEmail(String otpCode) async {
    setState(() {
      _isLoading = true;
    });
    String apiUrl = '$backendUrl/api/auth/verify-otp';
    final Map<String, dynamic> data = {
      'email': widget.email,
      'otp': int.parse(otpCode),
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
      final message = responseData['message'] ?? 'Verification successful!';
      showDialog(
        context: context,
        builder: (context) {
          submitLink(widget.role, context);
          return MessagePopup(
            imageAssetPath: "assets/images/verify-email-icon.png",
            title: "Congratulations: Verify email Successfully",
            text: message,
            height: 0.65,
          );
        },
      );
    } else {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final message = responseData['message'];
      showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).pop();
          });
          return MessagePopup(
            imageAssetPath: "assets/images/failure.png",
            title: "Error: Verify email Failed",
            text: message,
            height: 0.6,
          );
        },
      );
    }
  }

  Future<Null> submitLink(String role, BuildContext context) {
    return Future.delayed(const Duration(seconds: 3), () {
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
                    imageAssetPath: 'assets/images/verify-email.png',
                    height: 200,
                    title: 'OTP Verification',
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(50, 10, 50, 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 15),
                        const SizedBox(
                          width: 80,
                          height: 80,
                          child: Image(
                            image: AssetImage("assets/images/otp.png"),
                          ),
                        ),
                        const SizedBox(height: 10),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1600),
                          child: Column(
                            children: [
                              const SizedBox(height: 20.0),
                              const Text(
                                  "Enter the verification code sent to your email",
                                  textAlign: TextAlign.center),
                              const SizedBox(height: 20.0),
                              OtpTextField(
                                numberOfFields: 5,
                                fillColor: Colors.black.withOpacity(0.1),
                                filled: true,
                                fieldWidth: 60,
                                styles: [],
                                onSubmit: (code) {
                                  print("OTP is => $code");
                                  _verifyEmail(code);
                                },
                              ),
                              const SizedBox(height: 10),
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
