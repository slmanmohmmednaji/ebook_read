import 'package:ebook_read/models/book.dart';
import 'package:ebook_read/screens/reading_screen.dart';

import 'package:ebook_read/services/book_service.dart';
import 'package:flutter/material.dart';

class BookDetailsScreen extends StatefulWidget {
  final Book book;

  const BookDetailsScreen({Key? key, required this.book}) : super(key: key);

  @override
  _BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  late Book _currentBook;

  @override
  void initState() {
    super.initState();
    _currentBook = widget.book;
  }

  void _toggleFavorite() {
    setState(() {
      BookService().toggleFavorite(_currentBook.id);
      _currentBook = BookService().getBookById(_currentBook.id) ?? _currentBook;
    });
  }

  void _toggleDownloaded() {
    setState(() {
      BookService().toggleDownloaded(_currentBook.id);
      _currentBook = BookService().getBookById(_currentBook.id) ?? _currentBook;
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
          'تفاصيل الكتاب',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Book Cover
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/placeholder_book.png', // Placeholder image
                  width: 200,
                  height: 280,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 24),

            // Book Title
            Text(
              _currentBook.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),

            // Author Name
            Text(
              _currentBook.author,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF6B7280),
              ),
            ),
            SizedBox(height: 16),

            // Rating and Category
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.amber,
                ),
                SizedBox(width: 4),
                Text(
                  _currentBook.rating.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                SizedBox(width: 16),
                Chip(
                  label: Text(
                    _currentBook.category,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF374151),
                    ),
                  ),
                  backgroundColor: Color(0xFFE5E7EB),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Description
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'الوصف',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              _currentBook.description ?? 'لا يوجد وصف متاح لهذا الكتاب.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF374151),
                height: 1.5,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 32),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ReadingScreen(book: _currentBook),
                        ),
                      );
                    },
                    icon: Icon(Icons.book_online, color: Colors.white),
                    label: Text(
                      'قراءة',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3B82F6),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _toggleDownloaded,
                    icon: Icon(
                      _currentBook.isDownloaded
                          ? Icons.download_done
                          : Icons.download,
                      color: Color(0xFF3B82F6),
                    ),
                    label: Text(
                      _currentBook.isDownloaded ? 'تم التحميل' : 'تحميل',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3B82F6),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _toggleFavorite,
                icon: Icon(
                  _currentBook.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color:
                      _currentBook.isFavorite ? Colors.red : Color(0xFF3B82F6),
                ),
                label: Text(
                  _currentBook.isFavorite
                      ? 'إزالة من المفضلة'
                      : 'إضافة إلى المفضلة',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3B82F6),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
