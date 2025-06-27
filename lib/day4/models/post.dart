class Posts {
  final String title;
  final String description;
  bool isFavorite;

  Posts({
    required this.title,
    required this.description,
    this.isFavorite = false,
  });
}
