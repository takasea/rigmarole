import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/widgets.dart';

class SelectPlatformUI extends StatelessWidget {
  const SelectPlatformUI({
    Key? key,
    this.platformAndroid,
    this.platformFuchsia,
    this.platformIOS,
    this.platformMacOS,
    this.platformLinux,
    this.platformWindows,
    this.platformWeb,
    required this.defaultUI,
  }) : super(key: key);

  final Widget? platformAndroid;
  final Widget? platformFuchsia;
  final Widget? platformIOS;
  final Widget? platformMacOS;
  final Widget? platformLinux;
  final Widget? platformWindows;
  final Widget? platformWeb;
  final Widget defaultUI;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return platformWeb ?? defaultUI;
    } else if (Platform.isAndroid) {
      return platformAndroid ?? defaultUI;
    } else if (Platform.isFuchsia) {
      return platformFuchsia ?? defaultUI;
    } else if (Platform.isIOS) {
      return platformIOS ?? defaultUI;
    } else if (Platform.isLinux) {
      return platformLinux ?? defaultUI;
    } else if (Platform.isMacOS) {
      return platformMacOS ?? defaultUI;
    } else if (Platform.isWindows) {
      return platformWindows ?? defaultUI;
    }

    return defaultUI;
  }
}
