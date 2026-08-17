// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:sidekick/src/modules/common/utils/open_link.dart';

class SettingsThemeMode {
  static const light = 'light';
  static const dark = 'dark';
  static const system = 'system';
  const SettingsThemeMode();
}

ThemeMode getThemeMode(String themeMode) {
  if (themeMode == SettingsThemeMode.light) {
    return ThemeMode.light;
  } else if (themeMode == SettingsThemeMode.dark) {
    return ThemeMode.dark;
  } else {
    return ThemeMode.system;
  }
}

typedef LaunchFunction = Future<void> Function(
  String projectPath, {
  String? customLocation,
});

enum SupportedIDE {
  VSCode,
  VSCodeInsiders,
  Cursor,
  Antigravity,
  AndroidStudio,
  XCode,
  Custom,
}

class IDE {
  final String name;
  final String displayName;
  final LaunchFunction launch;
  final Widget icon;

  IDE(
    SupportedIDE ideName,
    this.icon,
    this.launch, {
    String? displayName,
  })  : name = ideName.name,
        displayName = displayName ?? ideName.name;
}

final supportedIDEs = [
  IDE(
    SupportedIDE.VSCode,
    Icon(LucideIcons.codeXml),
    openVsCode,
  ),
  IDE(
    SupportedIDE.VSCodeInsiders,
    Icon(LucideIcons.braces),
    openVsCodeInsiders,
    displayName: 'VSCode Insiders',
  ),
  IDE(
    SupportedIDE.Cursor,
    Icon(LucideIcons.mousePointerClick),
    openCursor,
  ),
  IDE(
    SupportedIDE.Antigravity,
    Icon(LucideIcons.rocket),
    openAntigravity,
  ),
  IDE(
    SupportedIDE.AndroidStudio,
    Icon(LucideIcons.smartphone),
    openAndroidStudio,
    displayName: 'Android Studio',
  ),
  IDE(SupportedIDE.XCode, Icon(LucideIcons.compass), openXcode),
  IDE(SupportedIDE.Custom, const Icon(Icons.code_rounded), openCustom),
];
