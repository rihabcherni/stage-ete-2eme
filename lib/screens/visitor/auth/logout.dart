import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> logoutUser(BuildContext context, String token) async {
  final url = Uri.parse('$backendUrl/api/auth/logout/');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  try {
    final response = await http.post(url, headers: headers);
    if (response.statusCode == 200) {
      print('Logout successful');

      // Clear secure storage
      await _storage.deleteAll();

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
    } else {
      print('Logout failed');
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
  } catch (error) {
    print('Error occurred: $error');
  }
}
