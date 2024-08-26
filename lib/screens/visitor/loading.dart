import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:frontend/utils/constant.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/welcome');
    });

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeInDown(
              duration: const Duration(seconds: 3),
              child: Container(
                width: 150,
                height: 150,
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Image(
                  image: AssetImage('assets/images/logosncft.png'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SpinKitFadingCircle(
              color: Colors.white,
              size: 70.0,
            )
          ],
        ),
      ),
    );
  }
}
