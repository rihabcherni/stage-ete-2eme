import 'package:flutter/material.dart';
import 'package:frontend/screens/admin/accordion.dart';
import 'package:frontend/screens/admin/chat_screen.dart';
import 'package:frontend/screens/admin/adminDashboard.dart';
import 'package:frontend/screens/admin/messageUserList.dart';
import 'package:frontend/screens/admin/train_list_screen.dart';
import 'package:frontend/screens/admin/userList.dart';
import 'package:frontend/screens/client/clientDashboard.dart';
import 'package:frontend/screens/client/orderListPage.dart';
import 'package:frontend/screens/conducteur/conducteurDashboard.dart';
import 'package:frontend/screens/operateur/OperateurDashboard.dart';
import 'package:frontend/screens/visitor/auth/forgotPassword.dart';
import 'package:frontend/screens/visitor/auth/inscription.dart';
import 'package:frontend/screens/visitor/introScreen.dart';
import 'package:frontend/screens/visitor/auth/login.dart';
import 'package:frontend/screens/visitor/auth/profile.dart';
import 'package:frontend/screens/visitor/auth/update_password_screen.dart';
import 'package:frontend/screens/visitor/auth/verify_email_screen.dart';
import 'package:frontend/screens/visitor/loading.dart';
import 'package:frontend/screens/visitor/settings.dart';

class ListeRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoadingScreen());
      case '/chat-list':
        return MaterialPageRoute(builder: (_) => UserListScreen());
      case '/chat':
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => ChatScreen(
            userId: args['userId']!,
            receiverId: args['receiverId']!,
          ),
        );
      case '/welcome':
        return MaterialPageRoute(builder: (_) => const IntroScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsPage());

      // auth
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/inscription':
        return MaterialPageRoute(builder: (_) => const InscriptionPage());
      case '/update-password':
        return MaterialPageRoute(builder: (_) => const UpdatePasswordScreen());
      case '/forgot-password':
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case '/verify-email':
        if (args is Map<String, String>) {
          return MaterialPageRoute(
            builder: (_) =>
                VerifyEmailScreen(email: args['email']!, role: args['role']!),
          );
        }
        return _errorRoute(settings);

      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      // client
      case '/client':
        return MaterialPageRoute(builder: (_) => ClientDashboard());
      case '/client/order':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => OrderListPage(clientId: args),
          );
        }
        return _errorRoute(settings);

      // admin
      case '/admin':
        return MaterialPageRoute(builder: (_) => const AdminDashboardScreen());
      case '/admin/liste-user':
        return MaterialPageRoute(builder: (_) => const UserListPage());
      case '/admin/train':
        return MaterialPageRoute(builder: (_) => TrainListScreen());

      // operateur
      case '/operateur':
        return MaterialPageRoute(
            builder: (_) => const OperateurDashboardScreen());

      // conducteur
      case '/conducteur':
        return MaterialPageRoute(
            builder: (_) => const ConducteurDashboardScreen());

      default:
        return _errorRoute(settings);
    }
  }

  static Route<dynamic> _errorRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error page'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('ERROR: Route ${settings.name} not found.'),
              if (settings.arguments != null)
                Text('Arguments: ${settings.arguments.toString()}'),
            ],
          ),
        ),
      );
    });
  }
}
