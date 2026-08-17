import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:sidekick/src/modules/common/utils/helpers.dart';
import 'package:sidekick/src/modules/common/utils/open_link.dart';

import '../../components/atoms/refresh_button.dart';
import '../../components/atoms/typography.dart';
import '../../components/organisms/screen.dart';
import 'news.dto.dart';
import 'news.provider.dart';

/// Screen listing the latest Flutter announcements
class NewsScreen extends HookConsumerWidget {
  /// Constructor
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(flutterNewsProvider.notifier);
    final state = ref.watch(flutterNewsProvider);

    Future<void> onRefresh() async {
      await notifier.refetch();
    }

    Future<void> onMarkAllRead() async {
      await notifier.markAllRead();
    }

    Future<void> onOpen(FlutterNewsPost post) async {
      await notifier.markRead(post.id);
      await openLink(post.url);
    }

    return SkScreen(
      title: context.i18n('modules:news.title'),
      actions: [
        Caption(
          context.i18n(
            'modules:news.unread',
            variables: {'count': state.unreadCount},
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          tooltip: context.i18n('modules:news.markAllRead'),
          icon: const Icon(LucideIcons.checkCheck, size: 20),
          onPressed: state.posts.isEmpty ? null : onMarkAllRead,
        ),
        const SizedBox(width: 10),
        RefreshButton(
          onPressed: onRefresh,
        ),
        const SizedBox(width: 10),
      ],
      child: _buildBody(context, state, onOpen),
    );
  }

  Widget _buildBody(
    BuildContext context,
    FlutterNewsState state,
    Future<void> Function(FlutterNewsPost) onOpen,
  ) {
    if (state.posts.isEmpty) {
      if (state.loading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state.error != null) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(LucideIcons.cloudOff, size: 32),
                const SizedBox(height: 12),
                Paragraph(
                  context.i18n('modules:news.loadError'),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      }
      return Center(
        child: Paragraph(context.i18n('modules:news.isEmpty')),
      );
    }

    final scrollController = ScrollController();
    return CupertinoScrollbar(
      controller: scrollController,
      child: ListView.separated(
        controller: scrollController,
        padding: const EdgeInsets.fromLTRB(10, 60, 10, 20),
        itemCount: state.posts.length,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final post = state.posts[index];
          final isRead = state.readIds.contains(post.id);
          return ListTile(
            leading: Icon(
              isRead ? LucideIcons.mailOpen : LucideIcons.mail,
              size: 20,
              color: isRead
                  ? null
                  : Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              post.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                _formatMeta(context, post),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            trailing: const Icon(
              LucideIcons.externalLink,
              size: 16,
            ),
            onTap: () => onOpen(post),
          );
        },
      ),
    );
  }

  String _formatMeta(BuildContext context, FlutterNewsPost post) {
    final parts = <String>[];
    if (post.author != null && post.author!.isNotEmpty) {
      parts.add(post.author!);
    }
    if (post.published != null) {
      parts.add(DateFormat.yMMMd().format(post.published!));
    }
    return parts.join(' · ');
  }
}