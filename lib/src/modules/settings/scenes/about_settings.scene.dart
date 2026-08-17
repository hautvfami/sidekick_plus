import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sidekick/src/components/atoms/typography.dart';
import 'package:sidekick/src/modules/common/constants.dart';
import 'package:sidekick/src/modules/common/utils/helpers.dart';
import 'package:sidekick/src/modules/common/utils/open_link.dart';

import '../../../version.dart';

const kDonateUrl = 'https://paypal.me/hautvfami';

/// Settings section about
class AboutSettingsScene extends StatelessWidget {
  /// Constructor
  const AboutSettingsScene({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: ListView(
        children: [
          Row(
            children: [
              const Icon(LucideIcons.gitFork, size: 32),
              const SizedBox(width: 10),
              Text(
                context.i18n('modules:settings.scenes.about'),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Paragraph(
              context.i18n('modules:settings.scenes.aboutDescription'),
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(LucideIcons.info, size: 20),
            title: Text(
              context.i18n('modules:selectedDetail.components.version'),
            ),
            trailing: const Text(packageVersion),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(LucideIcons.gitFork, size: 20),
            title: Text(
              context.i18n('modules:settings.scenes.aboutForkedFrom'),
            ),
            subtitle: const Text('fluttertools/sidekick'),
            trailing: const Icon(LucideIcons.externalLink, size: 18),
            onTap: () => openLink(kSidekickUpstreamUrl),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(LucideIcons.codeXml, size: 20),
            title: Text(
              context.i18n('modules:settings.scenes.aboutVisitRepo'),
            ),
            subtitle: const Text('hautvfami/sidekick_plus'),
            trailing: const Icon(LucideIcons.externalLink, size: 18),
            onTap: () => openLink(kGithubSidekickUrl),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(LucideIcons.heart, size: 20),
            title: Text(
              context.i18n('modules:settings.scenes.aboutDonate'),
            ),
            subtitle: Text(
              context.i18n('modules:settings.scenes.aboutDonateSubtitle'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: Column(
              children: [
                QrImageView(
                  data: kDonateUrl,
                  version: QrVersions.auto,
                  size: 160,
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: 12),
                Paragraph(
                  context.i18n('modules:settings.scenes.aboutDonateQrHint'),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => openLink(kDonateUrl),
                  icon: const Icon(LucideIcons.externalLink, size: 18),
                  label: Text(
                    context.i18n('modules:settings.scenes.aboutDonateOpenPaypal'),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 12, right: 20),
            child: Paragraph(
              context.i18n('modules:settings.scenes.aboutContributionsWelcome'),
            ),
          ),
        ],
      ),
    );
  }
}
