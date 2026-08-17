import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'news.dto.dart';
import 'news.service.dart';

final _kNewsReadKey = 'flutter_news_read_ids';

/// Provider of the Flutter announcements feed
final flutterNewsProvider =
    StateNotifierProvider<FlutterNewsNotifier, FlutterNewsState>((_) {
  return FlutterNewsNotifier();
});

/// State notifier for the Flutter announcements feed
class FlutterNewsNotifier extends StateNotifier<FlutterNewsState> {
  /// Constructor. Loads persisted read state then kicks off a non-blocking
  /// fetch, so the app is never blocked waiting for the feed.
  FlutterNewsNotifier() : super(const FlutterNewsState()) {
    _init();
  }

  Future<void> _init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final readIds = prefs.getStringList(_kNewsReadKey) ?? const [];
      state = state.copyWith(readIds: readIds.toSet(), loading: true);
    } catch (_) {
      state = state.copyWith(loading: true);
    }

    // Fire and forget: fetch updates state when it resolves.
    refetch();
  }

  /// (Re)fetches the feed and updates state. Never blocks the caller.
  Future<void> refetch() async {
    try {
      final posts = await fetchFlutterAnnouncements();
      state = state.copyWith(posts: posts, loading: false, error: null);
    } on Exception catch (e) {
      state = state.copyWith(
        loading: false,
        error: e.toString(),
      );
    }
  }

  /// Marks a single post as read
  Future<void> markRead(String id) async {
    if (state.readIds.contains(id)) {
      return;
    }
    final updated = {...state.readIds, id};
    state = state.copyWith(readIds: updated);
    await _persistReadIds(updated.toList());
  }

  /// Marks every known post as read
  Future<void> markAllRead() async {
    final all = state.posts.map((post) => post.id).toSet();
    state = state.copyWith(readIds: all);
    await _persistReadIds(all.toList());
  }

  Future<void> _persistReadIds(List<String> ids) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_kNewsReadKey, ids);
    } catch (_) {
      // Best effort: failing to persist only affects the badge count.
    }
  }
}