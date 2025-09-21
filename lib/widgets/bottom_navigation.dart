import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  const BottomNavigation({
    Key? key,
    required this.currentIndex,
    required this.onTabTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home,
                label: 'الرئيسية',
                index: 0,
                isSelected: currentIndex == 0,
                context: context,
              ),
              _buildNavItem(
                icon: Icons.library_books,
                label: 'المكتبة',
                index: 1,
                isSelected: currentIndex == 1,
                context: context,
              ),
              _buildNavItem(
                icon: Icons.videocam,
                label: 'فيديو',
                index: 2,
                isSelected: currentIndex == 2,
                context: context,
              ),
              _buildNavItem(
                icon: Icons.web,
                label: 'ويب',
                index: 3,
                isSelected: currentIndex == 3,
                context: context,
              ),
              _buildNavItem(
                icon: Icons.contacts,
                label: 'اتصل بنا',
                index: 4,
                isSelected: currentIndex == 4,
                context: context,
              ),
              // _buildNavItem(
              //   icon: Icons.settings,
              //   label: 'الإعدادات',
              //   index: 5,
              //   isSelected: currentIndex == 5,
              //   context: context,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () => onTabTapped(index),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? Color(0xFF3B82F6) : Color(0xFF6B7280),
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Color(0xFF3B82F6) : Color(0xFF6B7280),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
