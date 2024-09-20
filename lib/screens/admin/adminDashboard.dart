import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/services/admin_dashboard_service.dart';
import 'package:frontend/utils/constant.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  late Future<Map<String, dynamic>> statistics;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String? fullName;

  @override
  void initState() {
    super.initState();
    statistics = AdminDashboardService().fetchStatistics();
    _fetchFullName();
  }

  Future<void> _fetchFullName() async {
    fullName = await _storage.read(key: 'fullName');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: statistics,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final stats = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.all(10.0),
              children: [
                Text(
                  'Welcome $fullName',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor),
                ),
                const SizedBox(
                  height: 8,
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    // Check if the width of the screen is greater than 600
                    bool isWideScreen = constraints.maxWidth > 600;

                    return isWideScreen
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text(
                                      'Ressources',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    GridView.count(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      crossAxisCount: 5,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      children: [
                                        StatisticCard(
                                          title: 'Trains',
                                          value: stats['Train'].toString(),
                                          color: Colors.deepOrange,
                                          icon: CupertinoIcons.train_style_one,
                                        ),
                                        StatisticCard(
                                          title: 'Wagons',
                                          value: stats['Wagon'].toString(),
                                          color: Colors.green,
                                          icon: Icons.train,
                                        ),
                                        StatisticCard(
                                          title: 'Capteurs IOT',
                                          value: stats['CapteurIot'].toString(),
                                          color: Colors.blue,
                                          icon: Icons.sensors,
                                        ),
                                        StatisticCard(
                                          title: 'Routes',
                                          value: stats['Route'].toString(),
                                          color: Colors.blue,
                                          icon: Icons.sensors,
                                        ),
                                        StatisticCard(
                                          title: 'Orders',
                                          value: stats['Order'].toString(),
                                          color: Colors.indigo,
                                          icon: CupertinoIcons.cart,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text(
                                      'Ressources Humaines',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    GridView.count(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      crossAxisCount: 5,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      children: [
                                        StatisticCard(
                                          title: 'Users',
                                          value: stats['User'].toString(),
                                          color: Colors.cyan,
                                          icon: CupertinoIcons.person,
                                        ),
                                        StatisticCard(
                                          title: 'Clients',
                                          value: stats['Client'].toString(),
                                          color: Colors.purple,
                                          icon: CupertinoIcons.person_2,
                                        ),
                                        StatisticCard(
                                          title: 'Conducteurs',
                                          value: stats['Conducteur'].toString(),
                                          color: Colors.orange,
                                          icon: CupertinoIcons.car_detailed,
                                        ),
                                        StatisticCard(
                                          title: 'Admins',
                                          value: stats['Administrateur']
                                              .toString(),
                                          color: Colors.brown,
                                          icon: CupertinoIcons.person_alt,
                                        ),
                                        StatisticCard(
                                          title: 'Opérateurs',
                                          value: stats['Operateur'].toString(),
                                          color: Colors.cyan,
                                          icon: CupertinoIcons.wrench,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              const Text(
                                'Ressources',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              GridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 4,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                children: [
                                  StatisticCard(
                                    title: 'Trains',
                                    value: stats['Train'].toString(),
                                    color: Colors.deepOrange,
                                    icon: CupertinoIcons.train_style_one,
                                  ),
                                  StatisticCard(
                                    title: 'Wagons',
                                    value: stats['Wagon'].toString(),
                                    color: Colors.green,
                                    icon: Icons.train,
                                  ),
                                  StatisticCard(
                                    title: 'Capteurs IOT',
                                    value: stats['CapteurIot'].toString(),
                                    color: Colors.blue,
                                    icon: Icons.sensors,
                                  ),
                                  StatisticCard(
                                    title: 'Orders',
                                    value: stats['Order'].toString(),
                                    color: Colors.indigo,
                                    icon: CupertinoIcons.cart,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Ressources Humaines',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              GridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 4,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                children: [
                                  StatisticCard(
                                    title: 'Users',
                                    value: stats['User'].toString(),
                                    color: Colors.cyan,
                                    icon: CupertinoIcons.person,
                                  ),
                                  StatisticCard(
                                    title: 'Clients',
                                    value: stats['Client'].toString(),
                                    color: Colors.purple,
                                    icon: CupertinoIcons.person_2,
                                  ),
                                  StatisticCard(
                                    title: 'Conducteurs',
                                    value: stats['Conducteur'].toString(),
                                    color: Colors.orange,
                                    icon: CupertinoIcons.car_detailed,
                                  ),
                                  StatisticCard(
                                    title: 'Admins',
                                    value: stats['Administrateur'].toString(),
                                    color: Colors.brown,
                                    icon: CupertinoIcons.person_alt,
                                  ),
                                  StatisticCard(
                                    title: 'Opérateurs',
                                    value: stats['Operateur'].toString(),
                                    color: Colors.cyan,
                                    icon: CupertinoIcons.wrench,
                                  )
                                ],
                              ),
                            ],
                          );
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'Analyses',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: true),
                      titlesData: const FlTitlesData(show: true),
                      borderData: FlBorderData(show: true),
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true,
                          color: Colors.blue,
                          spots: [
                            const FlSpot(0, 3),
                            const FlSpot(1, 5),
                            const FlSpot(2, 2),
                            const FlSpot(3, 8),
                            const FlSpot(4, 6),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          color: Colors.blue,
                          value: 40,
                          title: 'Clients',
                        ),
                        PieChartSectionData(
                          color: Colors.green,
                          value: 30,
                          title: 'Conducteurs',
                        ),
                        PieChartSectionData(
                          color: Colors.orange,
                          value: 30,
                          title: 'Opérateurs',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

class StatisticCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  StatisticCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  icon,
                  size: 50,
                  color: Theme.of(context).primaryColor,
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue[900],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 5),
                  color: Theme.of(context).primaryColor.withOpacity(.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
