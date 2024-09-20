import 'package:flutter/material.dart';
import 'package:frontend/screens/admin/AdminCommandesScreen.dart';
import 'package:frontend/screens/admin/AdminMapScreen.dart';
import 'package:frontend/screens/admin/AdminReclamationScreen.dart';
import 'package:frontend/screens/admin/AdminTrainsScreen.dart';
import 'package:frontend/screens/admin/AdminUsersScreen.dart';
import 'package:frontend/screens/admin/adminDashboard.dart';
import 'package:frontend/screens/chat/chat_user_list.dart';
import 'package:frontend/screens/client/clientDashboard.dart';
import 'package:frontend/screens/client/order_page.dart';
import 'package:frontend/screens/conducteur/conducteurDashboard.dart';
import 'package:frontend/screens/operateur/OperateurDashboard.dart';
import 'package:frontend/screens/visitor/auth/profile.dart';
import 'package:frontend/screens/visitor/settings.dart';
import 'package:frontend/widgets/custom_drawer.dart';

List<BottomNavigationBarItem> adminNavItems = [
  const BottomNavigationBarItem(
      icon: Icon(Icons.dashboard), label: 'Dashboard'),
  const BottomNavigationBarItem(icon: Icon(Icons.train), label: 'Trains'),
  const BottomNavigationBarItem(icon: Icon(Icons.edit_road), label: 'Trajets'),
  const BottomNavigationBarItem(
      icon: Icon(Icons.receipt_long), label: 'Commandes'),
  const BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Users'),
  const BottomNavigationBarItem(
      icon: Icon(Icons.report_problem), label: 'Reclamation'),
];

List<BottomNavigationBarItem> clientNavItems = [
  const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
  const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart), label: 'Orders'),
  const BottomNavigationBarItem(
      icon: Icon(Icons.account_circle), label: 'Profile'),
];

List<BottomNavigationBarItem> conductorNavItems = [
  const BottomNavigationBarItem(icon: Icon(Icons.train), label: 'Trains'),
  const BottomNavigationBarItem(
      icon: Icon(Icons.location_on), label: 'Locations'),
];

List<BottomNavigationBarItem> operatorNavItems = [
  const BottomNavigationBarItem(
      icon: Icon(Icons.notifications), label: 'Notifications'),
  const BottomNavigationBarItem(icon: Icon(Icons.schedule), label: 'Schedule'),
];

class BottomNav extends StatefulWidget {
  final String userRole;

  BottomNav({required this.userRole});

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  final List<Widget> adminPages = [
    AdminDashboardScreen(),
    AdminTrainsScreen(),
    AdminMapScreen(),
    const AdminCommandesScreen(),
    const AdminUsersScreen(),
    const ChatUserList(),
    AdminReclamationScreen(),
    const ProfilePage(),
  ];

  final List<Widget> clientPages = [
    ClientDashboard(),
    OrderPage(),
    const SettingsPage(),
  ];

  final List<Widget> conductorPages = [
    const ConducteurDashboardScreen(),
  ];

  final List<Widget> operatorPages = [
    const OperateurDashboardScreen(),
    const SettingsPage(),
  ];

  List<BottomNavigationBarItem> getNavItems() {
    switch (widget.userRole) {
      case 'admin':
        return adminNavItems;
      case 'client':
        return clientNavItems;
      case 'conductor':
        return conductorNavItems;
      case 'operator':
        return operatorNavItems;
      default:
        return [];
    }
  }

  List<Widget> getPages() {
    switch (widget.userRole) {
      case 'admin':
        return adminPages;
      case 'client':
        return clientPages;
      case 'conductor':
        return conductorPages;
      case 'operator':
        return operatorPages;
      default:
        return [];
    }
  }

  List<String> getPageTitles() {
    switch (widget.userRole) {
      case 'admin':
        return [
          'Dashboard',
          'Trains',
          'Trajets',
          'Commandes',
          'Users',
          'Chat',
          'Reclamation',
          'Profil'
        ];
      case 'client':
        return ['Home', 'Orders', 'Profile'];
      case 'conductor':
        return ['Trains'];
      case 'operator':
        return ['Notifications', 'Schedule'];
      default:
        return [];
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 2, 45, 120),
                Color.fromARGB(255, 24, 131, 219),
                Colors.blue,
                Color.fromARGB(255, 24, 131, 219),
                Color.fromARGB(255, 2, 45, 120)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              getPageTitles()[_selectedIndex],
              style: const TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            actions: const <Widget>[
              IconButton(
                icon: Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                ),
                onPressed: null,
              ),
              IconButton(
                icon: Icon(
                  Icons.chat,
                  color: Colors.white,
                ),
                onPressed: null,
              ),
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                onPressed: null,
              ),
            ],
          ),
        ),
      ),
      drawer: CustomDrawer(actor: widget.userRole),
      body: getPages()[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 2, 45, 120),
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: Colors.grey,
        items: getNavItems(),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
