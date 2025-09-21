import 'package:ebook_read/models/book.dart';
import 'package:ebook_read/screens/book_details_screen.dart';
import 'package:ebook_read/screens/category_books_screen.dart';

import 'package:ebook_read/services/book_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Book> _allBooks = [];
  List<Book> _filteredBooks = [];
  List<Book> _recentBooks = [];
  List<Book> _popularBooks = [];

  @override
  void initState() {
    super.initState();
    _allBooks = BookService().getAllBooks();
    _recentBooks = BookService().getRecentBooks();
    _popularBooks = BookService().getPopularBooks();
    _filteredBooks = _allBooks; // Initially show all books

    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredBooks = _allBooks;
      } else {
        _filteredBooks = BookService().searchBooks(_searchController.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  // App Bar
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Color(0xFF1E3A8A),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.menu_book,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'قارئ الكتب الإلكترونية',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'البحث عن الكتب...',
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xFF6B7280),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Results Section
                    if (_searchController.text.isNotEmpty) ...[
                      Text(
                        'نتائج البحث',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: _filteredBooks.length,
                        itemBuilder: (context, index) {
                          final book = _filteredBooks[index];
                          return _buildBookCard(context, book);
                        },
                      ),
                      SizedBox(height: 32),
                    ] else ...[
                      // Recently Added Section
                      Text(
                        'المضافة حديثاً',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _recentBooks.length,
                          itemBuilder: (context, index) {
                            final book = _recentBooks[index];
                            return _buildHorizontalBookCard(context, book);
                          },
                        ),
                      ),
                      SizedBox(height: 32),

                      // Popular Books Section
                      Text(
                        'الكتب الشائعة',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: _popularBooks.length,
                        itemBuilder: (context, index) {
                          final book = _popularBooks[index];
                          return _buildBookCard(context, book);
                        },
                      ),
                      SizedBox(height: 32),

                      // Categories Section
                      Text(
                        'الفئات',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      SizedBox(height: 16),
                      GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        children: [
                          _buildCategoryCard(
                            'الأدب الكلاسيكي',
                            Icons.auto_stories,
                          ),
                          _buildCategoryCard(
                            'الخيال العلمي',
                            Icons.rocket_launch,
                          ),
                          _buildCategoryCard('التاريخ', Icons.history_edu),
                          _buildCategoryCard(
                            'التطوير الذاتي',
                            Icons.psychology,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigation(
      //   currentIndex: 0,
      //   onTabTapped: (index) {
      //     if (index == 1) {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => LibraryScreen()),
      //       );
      //     } else if (index == 2) {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => SettingsScreen()),
      //       );
      //     }
      //   },
      // ),
    );
  }

  Widget _buildHorizontalBookCard(BuildContext context, Book book) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailsScreen(book: book),
          ),
        );
      },
      child: Container(
        width: 140,
        margin: EdgeInsets.only(right: 16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 110,
                decoration: BoxDecoration(
                  color: Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Center(
                  child: Icon(
                    Icons.menu_book,
                    size: 40,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Text(
                      book.author,
                      style: TextStyle(fontSize: 10, color: Color(0xFF6B7280)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.star, size: 12, color: Colors.amber),
                        SizedBox(width: 2),
                        Text(
                          book.rating.toString(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookCard(BuildContext context, Book book) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailsScreen(book: book),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Center(
                  child: Icon(
                    Icons.menu_book,
                    size: 60,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    book.author,
                    style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, size: 16, color: Colors.amber),
                      SizedBox(width: 4),
                      Text(
                        book.rating.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryBooksScreen(category: title),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: Color(0xFF3B82F6)),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
