import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({super.key});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String _currentUrl = 'https://flutter.dev';
  final TextEditingController _urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _urlController.text = _currentUrl;
    
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
              _currentUrl = url;
              _urlController.text = url;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('خطأ في تحميل الصفحة: ${error.description}'),
                backgroundColor: Colors.red,
              ),
            );
          },
        ),
      )
      ..loadRequest(Uri.parse(_currentUrl));
  }

  void _navigateToUrl(String url) {
    // التأكد من وجود بروتوكول في الرابط
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }
    
    try {
      _controller.loadRequest(Uri.parse(url));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('رابط غير صحيح'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showBookmarkDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('المواقع المحفوظة'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.flutter_dash),
                title: const Text('Flutter'),
                subtitle: const Text('flutter.dev'),
                onTap: () {
                  Navigator.of(context).pop();
                  _navigateToUrl('https://flutter.dev');
                },
              ),
              ListTile(
                leading: const Icon(Icons.code),
                title: const Text('Dart'),
                subtitle: const Text('dart.dev'),
                onTap: () {
                  Navigator.of(context).pop();
                  _navigateToUrl('https://dart.dev');
                },
              ),
              ListTile(
                leading: const Icon(Icons.school),
                title: const Text('GitHub'),
                subtitle: const Text('github.com'),
                onTap: () {
                  Navigator.of(context).pop();
                  _navigateToUrl('https://github.com');
                },
              ),
              ListTile(
                leading: const Icon(Icons.article),
                title: const Text('Stack Overflow'),
                subtitle: const Text('stackoverflow.com'),
                onTap: () {
                  Navigator.of(context).pop();
                  _navigateToUrl('https://stackoverflow.com');
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('إغلاق'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('متصفح الويب'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // زر الرجوع
                IconButton(
                  onPressed: () async {
                    if (await _controller.canGoBack()) {
                      await _controller.goBack();
                    }
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                
                // زر التقدم
                IconButton(
                  onPressed: () async {
                    if (await _controller.canGoForward()) {
                      await _controller.goForward();
                    }
                  },
                  icon: const Icon(Icons.arrow_forward, color: Colors.white),
                ),
                
                // شريط العنوان
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: _urlController,
                      decoration: const InputDecoration(
                        hintText: 'أدخل رابط الموقع...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        prefixIcon: Icon(Icons.language),
                      ),
                      onSubmitted: _navigateToUrl,
                    ),
                  ),
                ),
                
                // زر التحديث
                IconButton(
                  onPressed: () => _controller.reload(),
                  icon: const Icon(Icons.refresh, color: Colors.white),
                ),
                
                // زر المواقع المحفوظة
                IconButton(
                  onPressed: _showBookmarkDialog,
                  icon: const Icon(Icons.bookmark, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          
          // مؤشر التحميل
          if (_isLoading)
            Container(
              color: Colors.white.withOpacity(0.8),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('جاري تحميل الصفحة...'),
                  ],
                ),
              ),
            ),
        ],
      ),
      
      // شريط سفلي للتحكم السريع
      bottomNavigationBar: Container(
        color: const Color(0xFF0D47A1),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () => _navigateToUrl('https://flutter.dev'),
              icon: const Icon(Icons.flutter_dash, color: Colors.white),
              tooltip: 'Flutter',
            ),
            IconButton(
              onPressed: () => _navigateToUrl('https://dart.dev'),
              icon: const Icon(Icons.code, color: Colors.white),
              tooltip: 'Dart',
            ),
            IconButton(
              onPressed: () => _navigateToUrl('https://github.com'),
              icon: const Icon(Icons.code_outlined, color: Colors.white),
              tooltip: 'GitHub',
            ),
            IconButton(
              onPressed: () => _navigateToUrl('https://stackoverflow.com'),
              icon: const Icon(Icons.help_outline, color: Colors.white),
              tooltip: 'Stack Overflow',
            ),
          ],
        ),
      ),
    );
  }
}

