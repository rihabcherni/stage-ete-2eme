import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';

class HeaderAuth extends StatelessWidget {
  const HeaderAuth({
    super.key,
    required this.imageAssetPath,
    required this.height,
    required this.title,
  });

  final String imageAssetPath;
  final double height;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: BottomSemiCircleClipper(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: height,
            padding: const EdgeInsets.all(20),
            color: kPrimaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(imageAssetPath),
                const SizedBox(height: 10),
                FadeInUp(
                  duration: const Duration(milliseconds: 1600),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: kWhiteColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 10,
          top: 20,
          child: FadeInUp(
            duration: const Duration(seconds: 1),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: kWhiteColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ],
    );
  }
}

class BottomSemiCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(
        size.width / 2, size.height + 30, size.width, size.height - 30);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
