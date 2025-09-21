import 'package:ebook_read/models/book.dart';
import 'package:flutter/material.dart';
// import 'package:ebook_reader/models/book.dart';

class ReadingScreen extends StatefulWidget {
  final Book book;

  const ReadingScreen({Key? key, required this.book}) : super(key: key);

  @override
  _ReadingScreenState createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  int _currentPage = 1;
  final int _totalPages = 324;
  bool _showControls = true;
  bool _showSettings = false;
  double _fontSize = 18.0;
  Color _backgroundColor = Colors.white;
  Color _textColor = Colors.black;
  bool _nightMode = false;

  // Sample text content for different pages
  final Map<int, String> _pageContent = {
    1: '''في يوم بارد ومشرق من شهر أبريل، كانت الساعات تدق الثالثة عشرة. ونستون سميث، وذقنه مدفونة في صدره في محاولة للهروب من الرياح الخبيثة، انزلق بسرعة عبر الأبواب الزجاجية لقصور النصر، وإن لم يكن بسرعة كافية لمنع دوامة من الغبار الرملي من الدخول معه.

كانت رائحة الردهة تفوح بالملفوف المسلوق والحصير القديم. في أحد طرفيها، كان هناك ملصق ملون، كبير جداً للعرض الداخلي، مثبت على الحائط.

كان يصور وجهاً ضخماً، يبلغ عرضه أكثر من متر: وجه رجل يبلغ من العمر حوالي خمسة وأربعين عاماً، بشارب أسود كثيف وملامح وسيمة وقاسية.''',
    2: '''نظر ونستون إلى الملصق. كانت العيون تتبعه أينما ذهب. في الأسفل، كانت هناك كلمات: "الأخ الأكبر يراقبك".

في الداخل، كان صوت يقرأ قائمة من الأرقام التي لها علاقة بإنتاج الحديد الخام. كان الصوت يأتي من لوحة معدنية مستطيلة مثل المرآة المعتمة والتي شكلت جزءاً من سطح الجدار الأيمن.

ضغط ونستون على مفتاح وانخفض الصوت إلى حد ما، رغم أن الكلمات كانت لا تزال مميزة. كان الجهاز (يُطلق عليه شاشة التلفاز) يمكن تخفيضه، لكن لا توجد طريقة لإغلاقه تماماً.''',
    3: '''انتقل إلى النافذة: شخصية صغيرة هشة، ونحافة جسده أصبحت واضحة بسبب الزي الأزرق الذي كان الزي الرسمي للحزب. كان شعره فاتحاً جداً، ووجهه محمراً بشكل طبيعي، وجلده خشناً من الصابون الرديء وشفرات الحلاقة الباهتة والبرد القارس للشتاء الذي انتهى للتو.

في الخارج، حتى من خلال النافذة المغلقة، بدا العالم بارداً. في الشارع، كانت دوامات صغيرة من الرياح تدور في الغبار والورق الممزق في دوامات، وعلى الرغم من أن الشمس كانت مشرقة والسماء زرقاء صافية، لم يكن هناك شيء يبدو ملوناً باستثناء الملصقات الملصقة في كل مكان.''',
  };

  void _nextPage() {
    if (_currentPage < _totalPages) {
      setState(() {
        _currentPage++;
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 1) {
      setState(() {
        _currentPage--;
      });
    }
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  void _toggleSettings() {
    setState(() {
      _showSettings = !_showSettings;
    });
  }

  void _changeFontSize(double size) {
    setState(() {
      _fontSize = size;
    });
  }

  void _changeBackgroundColor(Color color, Color textColor) {
    setState(() {
      _backgroundColor = color;
      _textColor = textColor;
    });
  }

  void _toggleNightMode() {
    setState(() {
      _nightMode = !_nightMode;
      if (_nightMode) {
        _backgroundColor = Color(0xFF1F2937);
        _textColor = Colors.white;
      } else {
        _backgroundColor = Colors.white;
        _textColor = Colors.black;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // Main Content
            GestureDetector(
              onTap: _toggleControls,
              child: Container(
                color: _backgroundColor,
                child: Column(
                  children: [
                    // Header (conditionally visible)
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: _showControls ? 60 : 0,
                      child: _showControls
                          ? Container(
                              color: _backgroundColor,
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: _textColor,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  Expanded(
                                    child: Text(
                                      'القراءة',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: _textColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.settings,
                                      color: _textColor,
                                    ),
                                    onPressed: _toggleSettings,
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ),

                    // Reading Content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Chapter Title
                            Text(
                              'الفصل ${(_currentPage / 10).ceil()}',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: _textColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 24),

                            // Reading Text
                            Text(
                              _pageContent[_currentPage] ??
                                  'محتوى الصفحة ${_currentPage} من كتاب "${widget.book.title}". هذا نص تجريبي لعرض كيفية عمل التنقل بين الصفحات في التطبيق.',
                              style: TextStyle(
                                fontSize: _fontSize,
                                color: _textColor,
                                height: 1.8,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Bottom Controls (conditionally visible)
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: _showControls ? 80 : 0,
                      child: _showControls
                          ? Container(
                              color: _backgroundColor,
                              padding: EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  ElevatedButton(
                                    onPressed:
                                        _currentPage > 1 ? _previousPage : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF3B82F6),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      'السابقة',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'صفحة $_currentPage من $_totalPages',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: _textColor.withOpacity(0.7),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: _currentPage < _totalPages
                                        ? _nextPage
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF3B82F6),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      'التالية',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                    ),
                  ],
                ),
              ),
            ),

            // Settings Panel
            if (_showSettings)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'إعدادات القراءة',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      SizedBox(height: 16),

                      // Font Size
                      Text(
                        'حجم الخط',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF374151),
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Slider(
                              value: _fontSize,
                              min: 12.0,
                              max: 24.0,
                              divisions: 6,
                              onChanged: _changeFontSize,
                            ),
                          ),
                          Text(
                            '${_fontSize.round()}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF374151),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),

                      // Background Color
                      Text(
                        'لون الخلفية',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF374151),
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => _changeBackgroundColor(
                                Colors.white, Colors.black),
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => _changeBackgroundColor(
                                Color(0xFFF5F5DC), Colors.black),
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Color(0xFFF5F5DC),
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => _changeBackgroundColor(
                                Color(0xFF1F2937), Colors.white),
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Color(0xFF1F2937),
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),

                      // Night Mode Toggle
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'الوضع الليلي',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF374151),
                            ),
                          ),
                          Switch(
                            value: _nightMode,
                            onChanged: (value) => _toggleNightMode(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
