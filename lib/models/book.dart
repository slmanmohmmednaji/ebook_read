class Book {
  final String id;
  final String title;
  final String author;
  final double rating;
  final String category;
  final String? description;
  final String? coverUrl;
  final bool isDownloaded;
  final bool isFavorite;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.rating,
    required this.category,
    this.description,
    this.coverUrl,
    this.isDownloaded = false,
    this.isFavorite = false,
  });

  Book copyWith({
    String? id,
    String? title,
    String? author,
    double? rating,
    String? category,
    String? description,
    String? coverUrl,
    bool? isDownloaded,
    bool? isFavorite,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      rating: rating ?? this.rating,
      category: category ?? this.category,
      description: description ?? this.description,
      coverUrl: coverUrl ?? this.coverUrl,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'rating': rating,
      'category': category,
      'description': description,
      'coverUrl': coverUrl,
      'isDownloaded': isDownloaded,
      'isFavorite': isFavorite,
    };
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      rating: json['rating'].toDouble(),
      category: json['category'],
      description: json['description'],
      coverUrl: json['coverUrl'],
      isDownloaded: json['isDownloaded'] ?? false,
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}

