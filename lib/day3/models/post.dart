class Post {
  int id;
  String? title;
  String? photo;
  Post(this.id, this.title, this.photo);

  static final List<Post> _posts = [];

  static List<Post> getPosts() => _posts;
  static void addPost(Post post) => _posts.add(post);
  static void removePost(int index) => _posts.removeAt(index);
}
