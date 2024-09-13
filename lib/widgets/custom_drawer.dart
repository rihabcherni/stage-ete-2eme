import 'package:flutter/material.dart';
import 'package:frontend/screens/visitor/auth/logout.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/utils/constant.dart';

class CustomDrawer extends StatelessWidget {
  final String actor;
  final AuthService _authService = AuthService();

  CustomDrawer({required this.actor});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Drawer Header with logo and app name
          DrawerHeader(
            decoration: const BoxDecoration(
              color: kPrimaryColor,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                Image.asset(
                  'assets/images/logo.png', // Path to your logo image
                  height: 60,
                ),
                // App name
                Text(
                  'SNCFT',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Drawer items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: _getDrawerItems(actor, context),
            ),
          ),
          // Inside your CustomDrawer widget
          Container(
            color: kPrimaryColor,
            child: ListTile(
              title: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: kPrimaryColor,
                  backgroundColor: Colors.white, // Text color
                ),
                onPressed: () {
                  // Trigger logout
                  logoutUser(context);
                },
                child: Text('Logout'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getDrawerItems(String actor, BuildContext context) {
    switch (actor) {
      case 'administrateur':
        return [
          _createDrawerItem(
              icon: Icons.dashboard,
              text: 'Dashboard',
              onTap: () => Navigator.pushNamed(context, '/admin')),
          _createDrawerItem(
              icon: Icons.settings,
              text: 'Settings',
              onTap: () => Navigator.pushNamed(context, '/settings')),
          _createDrawerItem(
              icon: Icons.train,
              text: 'Train',
              onTap: () => Navigator.pushNamed(context, '/admin/train')),
          _createDrawerItem(
              icon: Icons.person_add,
              text: 'User list',
              onTap: () => Navigator.pushNamed(context, '/admin/users')),
          _createDrawerItem(
              icon: Icons.person,
              text: 'Profile',
              onTap: () => Navigator.pushNamed(context, '/profile')),
        ];
      case 'client':
        return [
          _createDrawerItem(
              icon: Icons.shopping_cart,
              text: 'Dashboard',
              onTap: () => Navigator.pushNamed(context, '/client')),
          _createDrawerItem(
              icon: Icons.shopping_cart,
              text: 'Orders',
              onTap: () => Navigator.pushNamed(context, '/client/order')),
          _createDrawerItem(
              icon: Icons.support,
              text: 'Support',
              onTap: () => Navigator.pushNamed(context, '/settings')),
          _createDrawerItem(
              icon: Icons.person,
              text: 'Profile',
              onTap: () => Navigator.pushNamed(context, '/profile')),
        ];
      case 'conducteur':
        return [
          _createDrawerItem(
              icon: Icons.train,
              text: 'Routes',
              onTap: () => Navigator.pushNamed(context, '/conducteur')),
          _createDrawerItem(
              icon: Icons.schedule,
              text: 'Schedule',
              onTap: () => Navigator.pushNamed(context, '/conducteur')),
          _createDrawerItem(
              icon: Icons.person,
              text: 'Profile',
              onTap: () => Navigator.pushNamed(context, '/profile')),
        ];
      case 'operateur':
        return [
          _createDrawerItem(
              icon: Icons.control_camera,
              text: 'Operations',
              onTap: () => Navigator.pushNamed(context, '/operateur')),
          _createDrawerItem(
              icon: Icons.report,
              text: 'Reports',
              onTap: () => Navigator.pushNamed(context, '/operateur')),
          _createDrawerItem(
              icon: Icons.person,
              text: 'Profile',
              onTap: () => Navigator.pushNamed(context, '/profile')),
        ];
      default:
        return [
          _createDrawerItem(
              icon: Icons.error, text: 'Unknown Role', onTap: () {}),
        ];
    }
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
