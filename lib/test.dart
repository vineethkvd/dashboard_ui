// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Modern Dashboard',
//       theme: ThemeData(
//         brightness: Brightness.light,
//         primarySwatch: Colors.blue,
//       ),
//       home: DashboardScreen(),
//     );
//   }
// }

// class DashboardScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         title: Text("Dashboard"),
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.blueAccent, Colors.lightBlueAccent],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.notifications),
//             onPressed: () {},
//           ),
//           CircleAvatar(
//             backgroundColor: Colors.white,
//             radius: 18,
//             child: Icon(Icons.person, color: Colors.blueAccent),
//           ),
//           SizedBox(width: 16),
//         ],
//       ),
//       body: Row(
//         children: [
//           if (MediaQuery.of(context).size.width > 800) ...[
//             Expanded(
//               flex: 2,
//               child: SideDrawer(),
//             ),
//           ],
//           Expanded(
//             flex: 8,
//             child: DashboardContent(),
//           ),
//         ],
//       ),
//       drawer: MediaQuery.of(context).size.width <= 800
//           ? SideDrawer()
//           : null, // Show Drawer for mobile
//     );
//   }
// }

// class SideDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Container(
//         color: Colors.blueAccent,
//         child: Column(
//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Colors.blueAccent, Colors.lightBlueAccent],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   CircleAvatar(
//                     radius: 30,
//                     backgroundColor: Colors.white,
//                     child:
//                         Icon(Icons.person, color: Colors.blueAccent, size: 40),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Username',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: ListView(
//                 padding: EdgeInsets.zero,
//                 children: [
//                   ListTile(
//                     leading: Icon(Icons.dashboard, color: Colors.white),
//                     title: Text('Dashboard',
//                         style: TextStyle(color: Colors.white)),
//                     onTap: () {},
//                     tileColor: Colors.blue.withOpacity(0.1),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   ExpansionTile(
//                     leading: Icon(Icons.category, color: Colors.white),
//                     title: Text('Categories',
//                         style: TextStyle(color: Colors.white)),
//                     tilePadding: EdgeInsets.symmetric(horizontal: 16),
//                     childrenPadding: EdgeInsets.only(left: 16),
//                     children: [
//                       ListTile(
//                         title: Text('Category 1',
//                             style: TextStyle(color: Colors.white)),
//                         onTap: () {},
//                       ),
//                       ListTile(
//                         title: Text('Category 2',
//                             style: TextStyle(color: Colors.white)),
//                         onTap: () {},
//                       ),
//                     ],
//                     iconColor: Colors.white,
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.settings, color: Colors.white),
//                     title:
//                         Text('Settings', style: TextStyle(color: Colors.white)),
//                     onTap: () {},
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'Version 1.0.0',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DashboardContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: GridView.count(
//         crossAxisCount: MediaQuery.of(context).size.width > 800 ? 4 : 2,
//         crossAxisSpacing: 16,
//         mainAxisSpacing: 16,
//         children: [
//           DashboardCard(
//             icon: Icons.analytics,
//             label: 'Analytics',
//             color: Colors.orangeAccent,
//           ),
//           DashboardCard(
//             icon: Icons.category,
//             label: 'Categories',
//             color: Colors.lightGreenAccent,
//           ),
//           DashboardCard(
//             icon: Icons.shopping_cart,
//             label: 'Orders',
//             color: Colors.redAccent,
//           ),
//           DashboardCard(
//             icon: Icons.people,
//             label: 'Customers',
//             color: Colors.lightBlueAccent,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DashboardCard extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final Color color;

//   DashboardCard({required this.icon, required this.label, required this.color});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [color.withOpacity(0.6), color],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(icon, size: 50, color: Colors.white),
//               SizedBox(height: 10),
//               Text(
//                 label,
//                 style: TextStyle(color: Colors.white, fontSize: 18),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }