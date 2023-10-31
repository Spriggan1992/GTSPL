import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'gtspl_method_channel.dart';

abstract class GtsplPlatform extends PlatformInterface {
  /// Constructs a GtsplPlatform.
  GtsplPlatform() : super(token: _token);

  static final Object _token = Object();

  static GtsplPlatform _instance = MethodChannelGtspl();

  /// The default instance of [GtsplPlatform] to use.
  ///
  /// Defaults to [MethodChannelGtspl].
  static GtsplPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GtsplPlatform] when
  /// they register themselves.
  static set instance(GtsplPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool> connect(String ip, String port);

  Future<bool> disconnect();

  Future<String> status();

  Future<bool> sendCommand(String command);

  Future<bool> sendCommandAndFile(String command, String filepath);
}
