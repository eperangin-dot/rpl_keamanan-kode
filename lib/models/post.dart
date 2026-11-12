/// Model untuk data Post dari JSONPlaceholder API.
///
/// Merepresentasikan satu post dengan field sesuai endpoint
/// `https://jsonplaceholder.typicode.com/posts`.
class Post {
  /// ID user pemilik post.
  final int userId;

  /// ID unik post.
  final int id;

  /// Judul post.
  final String title;

  /// Isi/konten post.
  final String body;

  const Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  /// Membuat [Post] dari [Map] JSON.
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] as int? ?? 0,
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
    );
  }

  /// Mengubah [Post] menjadi [Map] JSON.
  Map<String, dynamic> toJson() {
    return {'userId': userId, 'id': id, 'title': title, 'body': body};
  }

  @override
  String toString() {
    return 'Post(id: $id, userId: $userId, title: $title)';
  }
}
