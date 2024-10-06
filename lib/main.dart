import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Import fl_chart
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  routes: [
    // Redirect '/' to '/dashboard'
    GoRoute(
      path: '/',
      redirect: (context, state) => '/dashboard',
    ),

    // ShellRoute for dashboard layout and its sub-routes
    ShellRoute(
      builder: (context, state, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Scaffold(
              appBar: constraints.maxWidth > 800
                  ? null // Hide app bar on wider screens
                  : AppBar(
                      title: Text("Modern Dashboard"),
                      actions: [Icon(Icons.person)], // Profile icon
                    ),
              drawer: constraints.maxWidth <= 800
                  ? Drawer(
                      child: DashboardMenu(),
                    )
                  : null,
              body: Row(
                children: [
                  if (constraints.maxWidth > 800)
                    Expanded(
                      flex: 2,
                      child: DashboardMenu(),
                    ),
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: child,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => DashboardHomePage(),
          routes: [
            GoRoute(
              path: 'analytics',
              builder: (context, state) => AnalyticsPage(),
              routes: [
                GoRoute(
                  path: 'overview',
                  builder: (context, state) => AnalyticsOverviewPage(),
                ),
                GoRoute(
                  path: 'sales',
                  builder: (context, state) => AnalyticsSalesPage(),
                ),
                GoRoute(
                  path: 'performance',
                  builder: (context, state) => AnalyticsPerformancePage(),
                ),
              ],
            ),
            GoRoute(
              path: 'reports',
              builder: (context, state) => ReportsPage(),
            ),
            GoRoute(
              path: 'settings',
              builder: (context, state) => SettingsPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);

// Provider for managing dashboard data
class DashboardProvider with ChangeNotifier {
  List<DashboardItem> _items = [
    DashboardItem(
      title: "Analytics",
      icon: Icons.analytics,
      route: '/dashboard/analytics',
    ),
    DashboardItem(
      title: "Reports",
      icon: Icons.pie_chart,
      route: '/dashboard/reports',
    ),
    DashboardItem(
      title: "Settings",
      icon: Icons.settings,
      route: '/dashboard/settings',
    ),
  ];

  List<DashboardItem> get items => _items;
}

class DashboardItem {
  final String title;
  final IconData icon;
  final String route;

  DashboardItem({required this.title, required this.icon, required this.route});
}

// Modern Sidebar Menu
class DashboardMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardProvider>(context);

    return Container(
      color: Colors.blue.shade900,
      child: ListView.builder(
        itemCount: dashboardProvider.items.length,
        itemBuilder: (context, index) {
          final item = dashboardProvider.items[index];

          // Check if the current item is 'Analytics' to display ExpansionTile
          if (item.title == "Analytics") {
            return Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent, // Remove black splash effect
                highlightColor: Colors.transparent,
              ),
              child: ExpansionTile(
                leading: Icon(item.icon, color: Colors.white),
                title: Text(item.title, style: TextStyle(color: Colors.white)),
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.dashboard, color: Colors.white),
                    title:
                        Text('Overview', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      context.go('/dashboard/analytics/overview');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.attach_money, color: Colors.white),
                    title: Text('Sales', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      context.go('/dashboard/analytics/sales');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.show_chart, color: Colors.white),
                    title: Text('Performance',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      context.go('/dashboard/analytics/performance');
                    },
                  ),
                ],
              ),
            );
          }

          // For other dashboard items, display them as normal ListTile
          return Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent, // Remove black splash effect
              highlightColor: Colors.transparent,
            ),
            child: ListTile(
              leading: Icon(item.icon, color: Colors.white),
              title: Text(item.title, style: TextStyle(color: Colors.white)),
              onTap: () {
                context.go(item.route);
              },
            ),
          );
        },
      ),
    );
  }
}

// Dashboard Home Page with Modern UI
class DashboardHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.count(
        crossAxisCount: MediaQuery.of(context).size.width > 800 ? 3 : 1,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        children: [
          _buildCard(
              context, "Analytics", Icons.analytics, "/dashboard/analytics"),
          _buildCard(context, "Reports", Icons.pie_chart, "/dashboard/reports"),
          _buildCard(
              context, "Settings", Icons.settings, "/dashboard/settings"),
        ],
      ),
    );
  }

  Widget _buildCard(
      BuildContext context, String title, IconData icon, String route) {
    return GestureDetector(
      onTap: () {
        context.go(route);
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: Colors.blue.shade700),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Analytics Page
class AnalyticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Analytics Page", style: TextStyle(fontSize: 24)),
    );
  }
}

// Analytics Overview Page with FL Chart
class AnalyticsOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            "Overview",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Expanded(child: LineChartSample()),
        ],
      ),
    );
  }
}

// Line Chart Sample using fl_chart
class LineChartSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                switch (value.toInt()) {
                  case 0:
                    return Text('Mon');
                  case 1:
                    return Text('Tue');
                  case 2:
                    return Text('Wed');
                  case 3:
                    return Text('Thu');
                  case 4:
                    return Text('Fri');
                  case 5:
                    return Text('Sat');
                  case 6:
                    return Text('Sun');
                  default:
                    return Text('');
                }
              },
            ),
          ),
        ),
        borderData:
            FlBorderData(show: true, border: Border.all(color: Colors.black12)),
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: 6,
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 1),
              FlSpot(1, 3),
              FlSpot(2, 2),
              FlSpot(3, 5),
              FlSpot(4, 3),
              FlSpot(5, 6),
              FlSpot(6, 2),
            ],
            isCurved: true,
            // color: [Colors.blue],
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}

// Placeholder for Analytics Sales Page
class AnalyticsSalesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Analytics Sales Page", style: TextStyle(fontSize: 24)),
    );
  }
}

// Placeholder for Analytics Performance Page
class AnalyticsPerformancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Analytics Performance Page", style: TextStyle(fontSize: 24)),
    );
  }
}

// Placeholder for Reports Page
class ReportsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Reports Page", style: TextStyle(fontSize: 24)),
    );
  }
}

// Placeholder for Settings Page
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Settings Page", style: TextStyle(fontSize: 24)),
    );
  }
}
