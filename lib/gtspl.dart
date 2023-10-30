import 'package:gtspl/gtspl_method_channel.dart';

class Gtspl {
  final channel = MethodChannelGtspl();
  bool _connected = false;

  bool get isConnected => _connected;

  Future<bool> connect(String ip, String port) async {
    _connected = await channel.connect(ip, port);
    return _connected;
  }

  Future<bool> disconnect() async {
    final res = await channel.disconnect();
    if (res) {
      _connected = false;
    }
    return res;
  }

  Future<String?> getPlatformVersion() {
    return channel.getPlatformVersion();
  }

  Future<String> status() {
    return channel.status();
  }

  Future<bool> sendCommand(String command, int amount) {
    return channel.sendCommand(command, amount);
  }

  Future<bool> sendCommandAndFile(String command, String filepath) {
    return channel.sendCommandAndFile(command, filepath);
  }
}
