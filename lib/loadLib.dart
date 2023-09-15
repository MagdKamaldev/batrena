// ignore_for_file: file_names
import 'dart:ffi';
import 'dart:io';

/// agnostic dynamic library loading on native platforms
///
/// see [#898](https://github.com/fzyzcjy/flutter_rust_bridge/pull/898)
DynamicLibrary loadLibForFlutter(String pathAndroid, String pathWindows) =>
    Platform.isIOS
        ? DynamicLibrary.process()
        : Platform.isMacOS
            ? DynamicLibrary.executable()
            : Platform.isAndroid
                ? DynamicLibrary.open(pathAndroid)
                : DynamicLibrary.open(pathWindows);
DynamicLibrary loadLibForDart(String path) =>
    Platform.isIOS ? DynamicLibrary.process() : DynamicLibrary.open(path);
