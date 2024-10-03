import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => RegistrationProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // Initialize GoRouter with ShellRoute for nested routing
  final GoRouter _router = GoRouter(
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return DashboardShell(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => DashboardHomeScreen(),
          ),
          GoRoute(
            path: '/analytics',
            name: 'analytics',
            builder: (context, state) => AnalyticsScreen(),
          ),
          GoRoute(
            path: '/categories',
            name: 'categories',
            builder: (context, state) => CategoriesScreen(),
          ),
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) => SettingsScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => RegistrationScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Modern Dashboard',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
    );
  }
}

// Shared Shell with AppBar and SideDrawer
class DashboardShell extends StatelessWidget {
  final Widget child;

  const DashboardShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Dashboard"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          GestureDetector(
            onTap: () => context.go('/register'), // Navigate to Registration
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
              child: Icon(Icons.person, color: Colors.blueAccent),
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Row(
        children: [
          // Show SideDrawer on wide screens
          if (MediaQuery.of(context).size.width > 800)
            Expanded(
              flex: 2,
              child: SideDrawer(),
            ),
          // Main Content Area
          Expanded(
            flex: 8,
            child: child, // Dynamic content based on route
          ),
        ],
      ),
      drawer: MediaQuery.of(context).size.width <= 800
          ? SideDrawer()
          : null, // Show Drawer for mobile
    );
  }
}

// SideDrawer with Navigation Options
class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get current location to highlight active route
    final String location = GoRouter.of(context).location;

    return Drawer(
      child: Container(
        color: Colors.blueAccent,
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child:
                        Icon(Icons.person, color: Colors.blueAccent, size: 40),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Username',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            // Navigation Items
            ListTile(
              leading: Icon(Icons.dashboard,
                  color: location == '/' ? Colors.white : Colors.white70),
              title: Text(
                'Home',
                style: TextStyle(
                    color: location == '/' ? Colors.white : Colors.white70),
              ),
              selected: location == '/',
              onTap: () {
                Navigator.pop(context); // Close the drawer
                context.go('/'); // Navigate to Home
              },
            ),
            ListTile(
              leading: Icon(Icons.analytics,
                  color:
                      location == '/analytics' ? Colors.white : Colors.white70),
              title: Text(
                'Analytics',
                style: TextStyle(
                    color: location == '/analytics'
                        ? Colors.white
                        : Colors.white70),
              ),
              selected: location == '/analytics',
              onTap: () {
                Navigator.pop(context); // Close the drawer
                context.go('/analytics'); // Navigate to Analytics
              },
            ),
            ListTile(
              leading: Icon(Icons.category,
                  color: location == '/categories'
                      ? Colors.white
                      : Colors.white70),
              title: Text(
                'Categories',
                style: TextStyle(
                    color: location == '/categories'
                        ? Colors.white
                        : Colors.white70),
              ),
              selected: location == '/categories',
              onTap: () {
                Navigator.pop(context); // Close the drawer
                context.go('/categories'); // Navigate to Categories
              },
            ),
            ListTile(
              leading: Icon(Icons.settings,
                  color:
                      location == '/settings' ? Colors.white : Colors.white70),
              title: Text(
                'Settings',
                style: TextStyle(
                    color: location == '/settings'
                        ? Colors.white
                        : Colors.white70),
              ),
              selected: location == '/settings',
              onTap: () {
                Navigator.pop(context); // Close the drawer
                context.go('/settings'); // Navigate to Settings
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Home Screen Content
class DashboardHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Welcome to the Dashboard!', style: TextStyle(fontSize: 24)),
    );
  }
}

// Analytics Screen Content
class AnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Analytics Screen', style: TextStyle(fontSize: 24)),
    );
  }
}

// Categories Screen Content
class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Categories Screen', style: TextStyle(fontSize: 24)),
    );
  }
}

// Settings Screen Content
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings Screen', style: TextStyle(fontSize: 24)),
    );
  }
}

// Registration Screen
class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: RegistrationForm(),
    );
  }
}

// Registration Form with Image Picker
class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;
  Uint8List? _selectedImage;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegistrationProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            // Name Field
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              onSaved: (value) => _name = value,
            ),
            SizedBox(height: 16),
            // Email Field
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              onSaved: (value) => _email = value,
            ),
            SizedBox(height: 16),
            // Image Picker Button
            ElevatedButton(
              onPressed: () async {
                await provider.pickImage();
                setState(() {
                  _selectedImage = provider.selectedImage;
                });
              },
              child: Text('Pick Profile Image'),
            ),
            SizedBox(height: 16),
            // Display Selected Image
            if (_selectedImage != null)
              Image.memory(_selectedImage!, height: 200, width: 200),
            // Submit Button
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Handle Registration Logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Registration Successful')),
                  );
                }
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

// Registration Provider for Image Picker
class RegistrationProvider extends ChangeNotifier {
  Uint8List? _selectedImage;

  Uint8List? get selectedImage => _selectedImage;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _selectedImage = await pickedFile.readAsBytes();
      notifyListeners();
    }
  }
}
