import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final String actor;
  final String clientId;

  CustomDrawer({required this.actor, required this.clientId});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: _getDrawerItems(actor, context),
      ),
    );
  }

  List<Widget> _getDrawerItems(String actor, BuildContext context) {
    switch (actor) {
      case 'Administrateur':
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
              onTap: () => Navigator.pushNamed(context, '/admin/liste-user')),
          _createDrawerItem(
              icon: Icons.person,
              text: 'profile',
              onTap: () => Navigator.pushNamed(context, '/profile')),
        ];
      case 'Client':
        return [
          _createDrawerItem(
              icon: Icons.shopping_cart,
              text: 'Dashboard',
              onTap: () => Navigator.pushNamed(context, '/client')),
          _createDrawerItem(
              icon: Icons.shopping_cart,
              text: 'Orders',
              onTap: () => Navigator.pushNamed(
                    context,
                    '/client/order',
                    arguments: clientId,
                  )),
          _createDrawerItem(
              icon: Icons.support,
              text: 'Support',
              onTap: () => Navigator.pushNamed(context, '/settings')),
          _createDrawerItem(
              icon: Icons.person,
              text: 'profile',
              onTap: () => Navigator.pushNamed(context, '/profile')),
        ];
      case 'Conductor':
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
              text: 'profile',
              onTap: () => Navigator.pushNamed(context, '/profile')),
        ];
      case 'Operator':
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
              text: 'profile',
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
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
