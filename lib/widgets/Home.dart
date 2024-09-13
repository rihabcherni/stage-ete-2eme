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

List<BottomNavigationBarItem> adminNavItems = [
  const BottomNavigationBarItem(
      icon: Icon(Icons.dashboard), label: 'Dashboard'),
  const BottomNavigationBarItem(icon: Icon(Icons.train), label: 'Trains'),
  const BottomNavigationBarItem(icon: Icon(Icons.edit_road), label: 'Trajets'),
  const BottomNavigationBarItem(
      icon: Icon(Icons.receipt_long), label: 'Commandes'),
  const BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Users'),
  const BottomNavigationBarItem(
      icon: Icon(Icons.mark_unread_chat_alt), label: 'Chat'),
  const BottomNavigationBarItem(
      icon: Icon(Icons.report_problem), label: 'Reclamation'),
  const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Profil'),
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

class HomePage extends StatefulWidget {
  final String userRole;

  HomePage({required this.userRole});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Define your pages here
  final List<Widget> adminPages = [
    AdminDashboardScreen(),
    AdminTrainsScreen(),
    AdminMapScreen(),
    const AdminCommandesScreen(),
    const AdminUsersScreen(),
    const ChatUserList(),
    const AdminReclamationScreen(),
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: getPages()[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: const Color.fromARGB(255, 8, 27, 238),
        backgroundColor: const Color.fromARGB(255, 2, 4, 6),
        items: getNavItems(),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
