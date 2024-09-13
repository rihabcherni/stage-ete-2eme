import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/utils/constant.dart';

Future<void> logoutUser(BuildContext context) async {
  final AuthService authService = AuthService();

  try {
    await authService.logoutUser(context);

    // Show a success message
    showDialog(
      context: context,
      builder: (context) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pushNamed('/');
        });
        return AlertDialog(
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.52,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage("assets/images/account.png"),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Congratulations',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Logout Successfully',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  SpinKitFadingCircle(
                    color: kPrimaryColor,
                    size: 40.0,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  } catch (error) {
    print('Logout failed: $error');

    // Show an error message
    showDialog(
      context: context,
      builder: (context) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pushNamed('/');
        });
        return AlertDialog(
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.52,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage("assets/images/account.png"),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Error',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Logout Failed',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  SpinKitFadingCircle(
                    color: kPrimaryColor,
                    size: 40.0,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
