/// A single announcement/blog post from the Flutter blog
class FlutterNewsPost {
  /// Constructor
  const FlutterNewsPost({
    required this.id,
    required this.title,
    required this.url,
    this.published,
    this.author,
  });

  /// Unique id of the post
  final String id;

  /// Post title
  final String title;

  /// Post url
  final String url;

  /// Publish date
  final DateTime? published;

  /// Author
  final String? author;
}

/// State of the Flutter announcements feed
class FlutterNewsState {
  /// Constructor
  const FlutterNewsState({
    this.posts = const [],
    this.readIds = const {},
    this.loading = false,
    this.error,
  });

  /// List of posts sorted newest first
  final List<FlutterNewsPost> posts;

  /// Ids of already read posts
  final Set<String> readIds;

  /// Whether the feed is currently loading
  final bool loading;

  /// Last error message if any
  final String? error;

  /// Number of unread posts
  int get unreadCount =>
      posts.where((post) => !readIds.contains(post.id)).length;

  /// Copy with overriden fields
  FlutterNewsState copyWith({
    List<FlutterNewsPost>? posts,
    Set<String>? readIds,
    bool? loading,
    String? error,
  }) {
    return FlutterNewsState(
      posts: posts ?? this.posts,
      readIds: readIds ?? this.readIds,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}