import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اتصل بنا'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // رأس الصفحة
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.school,
                    size: 60,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'مشروع تطبيق قارئ الكتب الإلكترونية',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Mobile Application Development',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // معلومات المشروع
            const Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'معلومات المشروع',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                    Divider(),
                    InfoRow(icon: Icons.assignment, text: 'رمز المادة: CS401'),
                    SizedBox(height: 8),
                    InfoRow(
                        icon: Icons.book,
                        text: 'اسم المادة: Mobile Application Development'),
                    SizedBox(height: 8),
                    InfoRow(icon: Icons.group, text: 'معرف المجموعة: G1'),
                    SizedBox(height: 8),
                    InfoRow(
                        icon: Icons.calendar_today,
                        text: 'العام الأكاديمي: 2024-2025'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // بيانات الطلاب
            const StudentInfoCard(
              name: "أحمد محمد علي",
              universityId: "202012345",
              groupId: "G1",
              courseCode: "CS401",
              courseName: "Mobile Application Development",
              role: "مطور التطبيق الرئيسي",
              email: "ahmed.mohamed@university.edu",
            ),

            const SizedBox(height: 16),

            const StudentInfoCard(
              name: "فاطمة أحمد حسن",
              universityId: "202012346",
              groupId: "G1",
              courseCode: "CS401",
              courseName: "Mobile Application Development",
              role: "مصممة واجهة المستخدم",
              email: "fatima.ahmed@university.edu",
            ),

            const SizedBox(height: 16),

            const StudentInfoCard(
              name: "محمد عبدالله سالم",
              universityId: "202012347",
              groupId: "G1",
              courseCode: "CS401",
              courseName: "Mobile Application Development",
              role: "مطور قاعدة البيانات",
              email: "mohammed.abdullah@university.edu",
            ),

            const SizedBox(height: 20),

            // معلومات الاتصال
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'معلومات الاتصال',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                    const Divider(),
                    const InfoRow(
                      icon: Icons.location_on,
                      text: 'الجامعة: جامعة التكنولوجيا والعلوم التطبيقية',
                    ),
                    const SizedBox(height: 8),
                    const InfoRow(
                      icon: Icons.business,
                      text: 'الكلية: كلية تقنية المعلومات',
                    ),
                    const SizedBox(height: 8),
                    const InfoRow(
                      icon: Icons.phone,
                      text: 'هاتف: +968 1234 5678',
                    ),
                    const SizedBox(height: 8),
                    const InfoRow(
                      icon: Icons.email,
                      text: 'البريد الإلكتروني: info@university.edu.om',
                    ),
                    const SizedBox(height: 16),

                    // أزرار التواصل
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('تم فتح تطبيق البريد الإلكتروني')),
                            );
                          },
                          icon: const Icon(Icons.email),
                          label: const Text('إرسال بريد'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0D47A1),
                            foregroundColor: Colors.white,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('تم فتح تطبيق الهاتف')),
                            );
                          },
                          icon: const Icon(Icons.phone),
                          label: const Text('اتصال'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // تذييل
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                children: [
                  Text(
                    'شكراً لاستخدام تطبيق قارئ الكتب الإلكترونية',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'تم تطوير هذا التطبيق كجزء من مشروع مادة تطوير تطبيقات الهاتف المحمول',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentInfoCard extends StatelessWidget {
  final String name;
  final String universityId;
  final String groupId;
  final String courseCode;
  final String courseName;
  final String role;
  final String email;

  const StudentInfoCard({
    super.key,
    required this.name,
    required this.universityId,
    required this.groupId,
    required this.courseCode,
    required this.courseName,
    required this.role,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFF0D47A1),
                  radius: 25,
                  child: Text(
                    name.split(' ').map((n) => n[0]).take(2).join(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D47A1),
                        ),
                      ),
                      Text(
                        role,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 20, thickness: 1),
            InfoRow(icon: Icons.badge, text: 'المعرف الجامعي: $universityId'),
            const SizedBox(height: 8),
            InfoRow(icon: Icons.group, text: 'معرف المجموعة: $groupId'),
            const SizedBox(height: 8),
            InfoRow(icon: Icons.code, text: 'رمز المادة: $courseCode'),
            const SizedBox(height: 8),
            InfoRow(icon: Icons.school, text: 'اسم المادة: $courseName'),
            const SizedBox(height: 8),
            InfoRow(icon: Icons.email, text: 'البريد الإلكتروني: $email'),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[700], size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
