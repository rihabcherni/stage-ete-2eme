import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/utils/constant.dart';

class MessagePopup extends StatelessWidget {
  const MessagePopup({
    super.key,
    required this.imageAssetPath,
    required this.title,
    required this.text,
    required this.height,
  });

  final String imageAssetPath;
  final String title;
  final String text;
  final double height;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 180,
                height: 180,
                child: Image(
                  image: AssetImage(imageAssetPath),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Center(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 4,
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
  }
}
