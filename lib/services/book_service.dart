import 'package:ebook_read/models/book.dart';
// import 'package:ebook_reader/models/book.dart';

class BookService {
  static final BookService _instance = BookService._internal();
  factory BookService() => _instance;
  BookService._internal();

  // Sample data
  final List<Book> _books = [
    Book(
      id: '1',
      title: 'The Great Gatsby',
      author: 'F. Scott Fitzgerald',
      rating: 4.5,
      category: 'Classic Literature',
      description:
          'A classic American novel set in the Jazz Age, exploring themes of wealth, love, and the American Dream.',
    ),
    Book(
      id: '2',
      title: 'To Kill a Mockingbird',
      author: 'Harper Lee',
      rating: 4.8,
      category: 'Fiction',
      description:
          'A gripping tale of racial injustice and childhood innocence in the American South.',
    ),
    Book(
      id: '3',
      title: '1984',
      author: 'George Orwell',
      rating: 4.7,
      category: 'Dystopian Fiction',
      description:
          'A dystopian social science fiction novel about totalitarian control and surveillance.',
    ),
    Book(
      id: '4',
      title: 'Pride and Prejudice',
      author: 'Jane Austen',
      rating: 4.6,
      category: 'Romance',
      description:
          'A romantic novel that critiques the British landed gentry at the end of the 18th century.',
    ),
  ];

  List<Book> getAllBooks() {
    return List.from(_books);
  }

  List<Book> getRecentBooks() {
    return _books.take(2).toList();
  }

  List<Book> getPopularBooks() {
    return _books.where((book) => book.rating >= 4.5).toList();
  }

  List<Book> getBooksByCategory(String category) {
    return _books.where((book) => book.category == category).toList();
  }

  List<Book> searchBooks(String query) {
    return _books
        .where((book) =>
            book.title.toLowerCase().contains(query.toLowerCase()) ||
            book.author.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Book? getBookById(String id) {
    try {
      return _books.firstWhere((book) => book.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Book> getFavoriteBooks() {
    return _books.where((book) => book.isFavorite).toList();
  }

  List<Book> getDownloadedBooks() {
    return _books.where((book) => book.isDownloaded).toList();
  }

  void toggleFavorite(String bookId) {
    final index = _books.indexWhere((book) => book.id == bookId);
    if (index != -1) {
      _books[index] = _books[index].copyWith(
        isFavorite: !_books[index].isFavorite,
      );
    }
  }

  void toggleDownloaded(String bookId) {
    final index = _books.indexWhere((book) => book.id == bookId);
    if (index != -1) {
      _books[index] = _books[index].copyWith(
        isDownloaded: !_books[index].isDownloaded,
      );
    }
  }

  List<String> getCategories() {
    return _books.map((book) => book.category).toSet().toList();
  }
}
