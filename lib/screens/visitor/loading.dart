import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/utils/constant.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/widgets/BottomNav.dart';
import 'package:frontend/screens/visitor/introScreen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    String? token = await _storage.read(key: 'token');
    String? role = await _storage.read(key: 'role');

    if (token != null && role != null) {
      _navigateToHome(role);
    } else {
      Future.delayed(const Duration(seconds: 5), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const IntroScreen()),
        );
      });
    }
  }

  void _navigateToHome(String role) {
    Future.delayed(const Duration(seconds: 5), () {
      switch (role) {
        case 'administrateur':
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => BottomNav(
                    userRole: 'admin',
                  )));
          break;
        case 'client':
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => BottomNav(
                    userRole: 'client',
                  )));
          break;
        case 'conducteur':
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => BottomNav(
                    userRole: 'conductor',
                  )));
          break;
        case 'operateur':
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => BottomNav(
                    userRole: 'operator',
                  )));
          break;
        default:
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const IntroScreen()));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeInDown(
              duration: const Duration(seconds: 3),
              child: const Image(
                image: AssetImage('assets/images/logosncft.png'),
                width: 200,
                height: 200,
              ),
            ),
            const SpinKitFadingCircle(
              color: kPrimaryColor,
              size: 50.0,
            )
          ],
        ),
      ),
    );
  }
}
