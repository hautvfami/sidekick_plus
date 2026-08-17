import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:sidekick/src/modules/common/dto/master.dto.dart';

import 'fvm_setup_button.dart';

/// Status for Master channel release
class FvmMasterStatus extends StatelessWidget {
  /// Constructor
  const FvmMasterStatus(
    this.masterChannel, {
    super.key,
  });

  /// Master
  final MasterDto masterChannel;
  @override
  Widget build(BuildContext context) {
    // If pending setup
    if (masterChannel.needSetup) {
      return SetupButton(release: masterChannel);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(LucideIcons.checkCircle, size: 20),
        SizedBox(width: masterChannel.isChannel ? 10 : 0),
        Text(masterChannel.sdkVersion ?? ''),
      ],
    );
  }
}
