import 'package:flutter/material.dart';
// import 'package:ebook_reader/widgets/bottom_navigation.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _nightModeEnabled = false;
  String _selectedFontSize = 'متوسط';
  String _selectedLanguage = 'العربية';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          'الإعدادات',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Account Settings
            _buildSettingsCard(
              title: 'إعدادات الحساب',
              children: [
                _buildSettingsItem(
                  icon: Icons.person,
                  title: 'الملف الشخصي',
                  subtitle: 'تعديل',
                  onTap: () {
                    // Handle profile edit
                  },
                ),
                _buildSettingsItem(
                  icon: Icons.lock,
                  title: 'كلمة المرور',
                  subtitle: 'تغيير',
                  onTap: () {
                    // Handle password change
                  },
                ),
              ],
            ),
            SizedBox(height: 16),

            // Reading Preferences
            _buildSettingsCard(
              title: 'تفضيلات القراءة',
              children: [
                _buildSettingsItem(
                  icon: Icons.text_fields,
                  title: 'حجم الخط',
                  subtitle: _selectedFontSize,
                  onTap: () {
                    _showFontSizeDialog();
                  },
                ),
                _buildSwitchItem(
                  icon: Icons.dark_mode,
                  title: 'الوضع الليلي',
                  value: _nightModeEnabled,
                  onChanged: (value) {
                    setState(() {
                      _nightModeEnabled = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),

            // General Settings
            _buildSettingsCard(
              title: 'عام',
              children: [
                _buildSwitchItem(
                  icon: Icons.notifications,
                  title: 'الإشعارات',
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),
                _buildSettingsItem(
                  icon: Icons.language,
                  title: 'اللغة',
                  subtitle: _selectedLanguage,
                  onTap: () {
                    _showLanguageDialog();
                  },
                ),
              ],
            ),
            SizedBox(height: 16),

            // About Section
            _buildSettingsCard(
              title: 'حول التطبيق',
              children: [
                _buildSettingsItem(
                  icon: Icons.info,
                  title: 'الإصدار',
                  subtitle: '1.0.0',
                  onTap: () {
                    // Handle version info
                  },
                ),
                _buildSettingsItem(
                  icon: Icons.privacy_tip,
                  title: 'سياسة الخصوصية',
                  onTap: () {
                    // Handle privacy policy
                  },
                ),
                _buildSettingsItem(
                  icon: Icons.help,
                  title: 'المساعدة والدعم',
                  onTap: () {
                    // Handle help
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigation(
      //   currentIndex: 2,
      //   onTabTapped: (index) {
      //     if (index == 0) {
      //       Navigator.pushReplacement(
      //         context,
      //         MaterialPageRoute(builder: (context) => MainNavigationScreen()),
      //       );
      //     } else if (index == 1) {
      //       Navigator.pushReplacement(
      //         context,
      //         MaterialPageRoute(builder: (context) => MainNavigationScreen()),
      //       );
      //     } else if (index == 3) {
      //       Navigator.pushReplacement(
      //         context,
      //         MaterialPageRoute(builder: (context) => MainNavigationScreen()),
      //       );
      //     }
      //   },
      // ),
    );
  }

  Widget _buildSettingsCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 24, color: Color(0xFF6B7280)),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 16, color: Color(0xFF374151)),
              ),
            ),
            if (subtitle != null) ...[
              Text(
                subtitle,
                style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
              ),
              SizedBox(width: 8),
            ],
            Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF6B7280)),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchItem({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Color(0xFF6B7280)),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: 16, color: Color(0xFF374151)),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Color(0xFF3B82F6),
          ),
        ],
      ),
    );
  }

  void _showFontSizeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('حجم الخط'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: Text('صغير'),
                value: 'صغير',
                groupValue: _selectedFontSize,
                onChanged: (value) {
                  setState(() {
                    _selectedFontSize = value!;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: Text('متوسط'),
                value: 'متوسط',
                groupValue: _selectedFontSize,
                onChanged: (value) {
                  setState(() {
                    _selectedFontSize = value!;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: Text('كبير'),
                value: 'كبير',
                groupValue: _selectedFontSize,
                onChanged: (value) {
                  setState(() {
                    _selectedFontSize = value!;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('اللغة'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: Text('العربية'),
                value: 'العربية',
                groupValue: _selectedLanguage,
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value!;
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                title: Text('English'),
                value: 'English',
                groupValue: _selectedLanguage,
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value!;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
