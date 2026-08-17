import 'dart:io';
import 'package:url_launcher/url_launcher_string.dart';

import 'which.dart';

Future<void> openLink(String url) async {
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  } else {
    throw "Error";
  }
}

Future<void> openPath(String url) async {
  if (Platform.isWindows) {
    await Process.start('start', [url]);
  } else if (Platform.isMacOS) {
    await Process.start('open', [url]);
  } else if (Platform.isLinux) {
    await Process.start('xdg-open', [url]);
  }
}

Future<void> openVsCode(
  String path, {
  String? customLocation,
}) {
  return _openVscodeFamily(
    path,
    command: 'code',
    uriScheme: 'vscode',
  );
}

Future<void> openVsCodeInsiders(
  String path, {
  String? customLocation,
}) {
  return _openVscodeFamily(
    path,
    command: 'code-insiders',
    uriScheme: 'vscode-insiders',
  );
}

Future<void> openCursor(
  String path, {
  String? customLocation,
}) {
  return _openVscodeFamily(
    path,
    command: 'cursor',
    uriScheme: 'cursor',
  );
}

Future<void> openAntigravity(
  String path, {
  String? customLocation,
}) {
  return _openVscodeFamily(
    path,
    command: 'antigravity',
    uriScheme: 'antigravity',
  );
}

Future<void> _openVscodeFamily(
  String path, {
  required String command,
  required String uriScheme,
}) async {
  if (Platform.isWindows || Platform.isLinux) {
    await Process.run(command, [path], runInShell: true);
  } else {
    // Check if the editor CLI is installed on path, if it is open the
    // folder, otherwise open it through the deep link scheme.
    final cli = await which(command);
    if (cli != null) {
      await Process.run(command, [path], runInShell: true);
    } else {
      final uri = '$uriScheme://file/$path';
      await openLink(uri);
    }
  }
}

Future<void> openAndroidStudio(
  String path, {
  String? customLocation,
}) async {
  if (Platform.isMacOS) {
    await Process.run(
      'open',
      ['-a', 'Android Studio', path],
      runInShell: true,
    );
  } else if (Platform.isWindows) {
    await Process.run('studio64', [path], runInShell: true);
  } else if (Platform.isLinux) {
    await Process.run('android-studio', [path], runInShell: true);
  }
}

Future<void> openXcode(
  String path, {
  String? customLocation,
}) async {
  final workspaceUri = '$path/ios/Runner.xcworkspace';
  return await openPath(workspaceUri);
}

Future<void> openCustom(
  String path, {
  String? customLocation,
}) async {
  if (customLocation == null) {
    return await openPath(path);
  }
  if (Platform.isMacOS) {
    await Process.run(
      "open",
      ["-a", customLocation, path],
      runInShell: true,
    );
  } else {
    await Process.run(
      customLocation,
      [path],
      runInShell: true,
    );
  }
}
