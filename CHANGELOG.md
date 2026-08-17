# Changelog

## Sidekick+ 1.2.0 - 2026-08-17

Sidekick+ — community fork of [fluttertools/sidekick](https://github.com/fluttertools/sidekick).

### Added

- New **News** tab: latest Flutter announcements (from the Flutter blog Atom feed), unread badge on the navigation rail, "mark all as read", read state persisted locally, and auto-mark-read when opening an article
- IDE support: **VSCode Insiders**, **Cursor**, **Antigravity** and **Android Studio** in project settings
- Keyboard shortcut to jump to the News tab (`Cmd/Ctrl+4`)

### Changed

- Replaced the purple theme with Flutter blue (`#0175C2`) in both light and dark themes (removed unused purple/blue theme variants)
- Settings and app version moved to the navigation rail; version pinned to the bottom of the rail
- Navigation labels/icons cleaned up: "Explore" renamed to **Releases** (rocket icon)
- Default window size increased to 1024×500
- Update/issue links now point to the Sidekick+ fork repository
- Upgraded report: added `xml`; new `flutter_acrylic` based window effects preserved

### Fixed

- Flutter SDK version detection now reads `bin/cache/flutter.version.json` (FVM)
- Light theme no longer carries leftover purple tints (M3 seed + app bar color)
- Header/content overlap in the News screen
- CI: `upload-artifact` upgraded to v4; Windows packaging uses the correct `build/windows/x64/runner/Release` output path; Windows MSIX now builds with Flutter's default test certificate (certificate args removed); Microsoft Store workflow removed

## 0.1.1 - 2021-06-19

### Added

- Github trending repos
- Flutter favorites

## 0.1.0 - 2021-06-16

### Fixed

- Issue when theme brightness does not match platform brightness

## 0.0.9 - 2021-06-15

### Changed

- Updated releases endpoint

## 0.0.8 - 2021-06-03

### Fixed

- master channel not showing in installed releases

## 0.0.7 - 2021-06-02

### Changed

- Projects are now added explicitly
