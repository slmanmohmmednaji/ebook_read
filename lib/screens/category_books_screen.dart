import 'package:ebook_read/models/book.dart';
import 'package:ebook_read/screens/book_details_screen.dart';

import 'package:ebook_read/services/book_service.dart';
import 'package:flutter/material.dart';

class CategoryBooksScreen extends StatefulWidget {
  final String category;

  const CategoryBooksScreen({Key? key, required this.category})
      : super(key: key);

  @override
  _CategoryBooksScreenState createState() => _CategoryBooksScreenState();
}

class _CategoryBooksScreenState extends State<CategoryBooksScreen> {
  List<Book> _books = [];

  @override
  void initState() {
    super.initState();
    _books = BookService().getBooksByCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          widget.category,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
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
      body: _books.isEmpty
          ? Center(
              child: Text(
                'لا توجد كتب في هذه الفئة حالياً.',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF6B7280),
                ),
              ),
            )
          : GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _books.length,
              itemBuilder: (context, index) {
                final book = _books[index];
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFE5E7EB),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
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
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                book.author,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF6B7280),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.amber,
                                  ),
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
              },
            ),
    );
  }
}
