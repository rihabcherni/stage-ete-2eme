import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/screens/visitor/auth/logout.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/utils/constant.dart';

class CustomDrawer extends StatefulWidget {
  final String actor;

  CustomDrawer({required this.actor});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final AuthService _authService = AuthService();
  User? _user;
  final String baseImageUrl = 'http://127.0.0.1:5000';

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    String? token = await _storage.read(key: 'token');

    if (token != null) {
      User? userProfile = await _authService.getUserProfile(token);

      if (userProfile != null) {
        setState(() {
          _user = userProfile;
        });
      } else {
        print('Failed to load user profile.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: kPrimaryColor,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: _user!.photo.isNotEmpty
                      ? NetworkImage('$baseImageUrl${_user!.photo}')
                      : const AssetImage('assets/images/avatar.png')
                          as ImageProvider,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${_user!.firstName} ${_user!.lastName}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _user!.email,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _user!.role,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: _getDrawerItems(widget.actor, context),
            ),
          ),
          Container(
            color: kPrimaryColor,
            child: ListTile(
              title: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: kPrimaryColor,
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  logoutUser(context);
                },
                child: const Text('Logout'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getDrawerItems(String actor, BuildContext context) {
    switch (actor) {
      case 'admin':
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
              icon: Icons.person_add,
              text: 'Chat',
              onTap: () => Navigator.pushNamed(context, '/admin/chat-list')),
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
      case 'conductor':
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
      case 'operator':
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
