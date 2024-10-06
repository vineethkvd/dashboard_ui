import 'package:flutter/material.dart';
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
              path: 'analytics', // final URL: /dashboard/analytics
              builder: (context, state) => AnalyticsPage(),
            ),
            GoRoute(
              path: 'reports', // final URL: /dashboard/reports
              builder: (context, state) => ReportsPage(),
            ),
            GoRoute(
              path: 'settings', // final URL: /dashboard/settings
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
          return ListTile(
            leading: Icon(item.icon, color: Colors.white),
            title: Text(item.title, style: TextStyle(color: Colors.white)),
            onTap: () {
              context.go(item.route);
            },
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

// Reports Page
class ReportsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Reports Page", style: TextStyle(fontSize: 24)),
    );
  }
}

// Settings Page
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Settings Page", style: TextStyle(fontSize: 24)),
    );
  }
}
