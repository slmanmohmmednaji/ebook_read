import 'package:ebook_read/models/book.dart';
import 'package:ebook_read/screens/book_details_screen.dart';
import 'package:ebook_read/screens/home_screen.dart';
import 'package:ebook_read/services/book_service.dart';
import 'package:flutter/material.dart';

class LibraryScreen extends StatefulWidget {
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Book> _downloadedBooks = [];
  List<Book> _favoriteBooks = [];
  List<Book> _readingListBooks = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadBooks();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadBooks() {
    setState(() {
      _downloadedBooks = BookService().getDownloadedBooks();
      _favoriteBooks = BookService().getFavoriteBooks();
      _readingListBooks =
          BookService().getAllBooks().take(2).toList(); // Sample reading list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          'مكتبتي',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Color(0xFF3B82F6),
          unselectedLabelColor: Color(0xFF6B7280),
          indicatorColor: Color(0xFF3B82F6),
          tabs: [
            Tab(text: 'المحملة'),
            Tab(text: 'المفضلة'),
            Tab(text: 'قائمة القراءة'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Filter and Sort Bar
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    // Handle sort
                  },
                  icon: Icon(Icons.sort, size: 16),
                  label: Text('ترتيب'),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
                Spacer(),
                OutlinedButton.icon(
                  onPressed: () {
                    // Handle filter
                  },
                  icon: Icon(Icons.filter_list, size: 16),
                  label: Text('تصفية'),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildBooksGrid(_downloadedBooks, 'لا توجد كتب محملة'),
                _buildBooksGrid(_favoriteBooks, 'لا توجد كتب مفضلة'),
                _buildBooksGrid(_readingListBooks, 'قائمة القراءة فارغة'),
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigation(
      //   currentIndex: 1,
      //   onTabTapped: (index) {
      //     if (index == 0) {
      //       Navigator.pushReplacement(
      //         context,
      //         MaterialPageRoute(builder: (context) => MainNavigationScreen()),
      //       );
      //     } else if (index == 2) {
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

  Widget _buildBooksGrid(List<Book> books, String emptyMessage) {
    if (books.isEmpty) {
      return _buildEmptyState(emptyMessage);
    }

    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return _buildBookCard(book);
      },
    );
  }

  Widget _buildBookCard(Book book) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailsScreen(book: book),
          ),
        ).then((_) => _loadBooks()); // Refresh when returning
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
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons.menu_book,
                        size: 60,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    if (book.isDownloaded)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.download_done,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    if (book.isFavorite)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Icon(
                          Icons.favorite,
                          size: 20,
                          color: Colors.red,
                        ),
                      ),
                  ],
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

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.library_books_outlined,
            size: 120,
            color: Color(0xFF6B7280).withOpacity(0.5),
          ),
          SizedBox(height: 24),
          Text(
            message,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B7280),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'ابدأ بإضافة كتب إلى مكتبتك الشخصية',
            style: TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Navigate to home screen
              //  Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF3B82F6),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'تصفح الكتب',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
