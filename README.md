![Image](https://img.shields.io/github/deployments/tiki/tiki-sdk-flutter/Production?label=deployment&logo=github)
![Image](https://img.shields.io/github/workflow/status/tiki/tiki-sdk-flutter/docs?label=docs&logo=github)
![Image](https://img.shields.io/pub/v/tiki_sdk_flutter?logo=dart)
![Image](https://img.shields.io/pub/points/tiki_sdk_flutter?logo=dart)
![Image](https://img.shields.io/github/license/tiki/tiki-sdk-flutter)

# TIKI SDK —build the new data economy

### [📚 Docs](https://docs.mytiki.com) &nbsp;&nbsp;[💬 Discord](https://discord.gg/tiki)

The Flutter implementation of TIKI's decentralized infrastructure plus abstractions to simplify the tokenization and application of data ownership, consent, and rewards. It wraps the **[tiki-sdk-dart](https://github.com/tiki/tiki-sdk-dart)** and adds specific implementations for Android and iOS.

This package should be used just for Flutter projects. For native implementation the specific SDKs are recommended. 

- **🤖 Android: [tiki-sdk-android](https://github.com/tiki/tiki-sdk-android)**
- **🍎 iOS: [tiki-sdk-ios](https://github.com/tiki/tiki-sdk-ios)**

### 🎬 How to get started

#### Depend on it
Run this command with Flutter:
```
$ flutter pub add tiki_sdk_flutter
```
This will add a line like this to your package's pubspec.yaml (and run an implicit flutter pub get):
```
    dependencies:
        tiki_sdk_flutter: ^0.0.11
```
Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn more.

#### Import it
Now in your Dart code, you can use:
```
import 'package:tiki_sdk_flutter/tiki_sdk_flutter.dart';
```

- **[API Reference ➝](https://pub.dev/documentation/tiki_sdk_flutter/latest/)**