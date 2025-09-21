import 'package:ebook_read/screens/contact_us_screen.dart';
import 'package:ebook_read/screens/home_screen.dart';
import 'package:ebook_read/screens/library_screen.dart';
// import 'package:ebook_read/screens/profile_screen.dart';
// import 'package:ebook_read/screens/settings_screen.dart';
import 'package:ebook_read/screens/video_screen.dart';
import 'package:ebook_read/screens/webview_screen.dart';
import 'package:ebook_read/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'قارئ الكتب الإلكترونية',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Cairo'),
      home: MainNavigationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    LibraryScreen(),
    VideoScreen(),
    WebviewScreen(),
    ContactUsScreen(),
    //ProfileScreen(), // Placeholder for profile screen
    // SettingsScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }
}

// Placeholder Profile Screen
// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF9FAFB),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 2,
//         title: Text(
//           'الحساب',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF1F2937),
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircleAvatar(
//               radius: 60,
//               backgroundColor: Color(0xFF3B82F6),
//               child: Icon(
//                 Icons.person,
//                 size: 60,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(height: 24),
//             Text(
//               'مستخدم التطبيق',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF1F2937),
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'user@example.com',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Color(0xFF6B7280),
//               ),
//             ),
//             SizedBox(height: 32),
//             ElevatedButton(
//               onPressed: () {
//                 // Handle logout
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFF3B82F6),
//                 padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: Text(
//                 'تسجيل الخروج',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
