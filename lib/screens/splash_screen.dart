import 'package:ebook_read/screens/login_screen.dart';

import '../main.dart';

import 'package:flutter/material.dart';
// import 'package:ebook_reader/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Auto navigate after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainNavigationScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE0F2FE),
              Color(0xFFBAE6FD),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Color(0xFF1E3A8A),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.menu_book,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 24),

              // App Title
              Text(
                'قارئ الكتب الإلكترونية',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A8A),
                ),
              ),
              SizedBox(height: 8),

              // App Subtitle
              Text(
                'اكتشف عالم القراءة الرقمية',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF3B82F6),
                ),
              ),
              SizedBox(height: 48),

              // Start Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3B82F6),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'ابدأ الآن',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
