import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'gtspl_platform_interface.dart';

/// An implementation of [GtsplPlatform] that uses method channels.
class MethodChannelGtspl extends GtsplPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('gtspl');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool> connect(String ip, String port) async {
    final status = await methodChannel
        .invokeMethod<bool>('connect', {"ip": ip, "port": port});
    return status ?? false;
  }

  @override
  Future<bool> disconnect() async {
    return await methodChannel.invokeMethod('disconnect');
  }

  @override
  Future<String> status() async {
    return await methodChannel.invokeMethod('status');
  }

  @override
  Future<bool> sendCommand(String command) async {
    return await methodChannel
        .invokeMethod("send_command", {"command": command});
  }

  @override
  Future<bool> sendCommandAndFile(String command, String filepath) async {
    return await methodChannel.invokeMethod(
        "send_command_and_file", {"command": command, "filepath": filepath});
  }
}
