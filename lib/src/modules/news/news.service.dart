import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

import 'news.dto.dart';

/// Flutter blog announcements Atom feed
const kFlutterAnnouncementsFeedUrl = 'https://flutter.dev/blog/feed.xml';

/// Fetches and parses the latest Flutter announcements.
///
/// Returns the posts sorted from newest to oldest. Never throws on a failed
/// request after a shared read timeout.
Future<List<FlutterNewsPost>> fetchFlutterAnnouncements() async {
  final response = await http.get(
    Uri.parse(kFlutterAnnouncementsFeedUrl),
  ).timeout(const Duration(seconds: 10));

  if (response.statusCode != 200) {
    throw Exception(
      'Failed to fetch announcements (HTTP ${response.statusCode})',
    );
  }

  final document = XmlDocument.parse(utf8.decode(response.bodyBytes));
  final posts = <FlutterNewsPost>[];

  for (final entry in document.findAllElements('entry')) {
    final title = entry
            .findElements('title')
            .firstOrNull
            ?.innerText
            .trim() ??
        '';

    final id = entry.findElements('id').firstOrNull?.innerText.trim() ?? title;
    final url = entry
            .findElements('link')
            .firstOrNull
            ?.getAttribute('href') ??
        '';
    final author = entry.findElements('author').firstOrNull?.innerText.trim();
    final publishedRaw = entry.findElements('published').firstOrNull?.innerText;

    if (title.isEmpty || url.isEmpty) {
      continue;
    }

    posts.add(
      FlutterNewsPost(
        id: id,
        title: title,
        url: url,
        published: DateTime.tryParse(publishedRaw ?? ''),
        author: author,
      ),
    );
  }

  posts.sort((a, b) {
    final aTime = a.published?.millisecondsSinceEpoch ?? 0;
    final bTime = b.published?.millisecondsSinceEpoch ?? 0;
    return bTime.compareTo(aTime);
  });

  return posts;
}