import 'package:flutter/material.dart';
import 'package:gtspl/gtspl.dart';

String statusToString(String status) {
  switch (status) {
    case "00":
      return "Printer Status : Normal";
    case "01":
      return "Printer Status : Head opened";
    case "02":
      return "Printer Status : Paper Jam";
    case "03":
      return "Printer Status : Paper Jam and head opened";
    case "04":
      return "Printer Status : Out of paper";
    case "05":
      return "Printer Status : Out of paper and head opened";
    case "08":
      return "Printer Status : Out of ribbon";
    case "09":
      return "Printer Status : Out of ribbon and head opened";
    case "0A":
      return "Printer Status : Out of ribbon and paper jam";
    case "0B":
      return "Printer Status : Out of ribbon, paper jam and head opened";
    case "0C":
      return "Printer Status : Out of ribbon and out of paper";
    case "0D":
      return "Printer Status : Out of ribbon, out of paper and head opened";
    case "10":
      return "Printer Status : Pause";
    case "20":
      return "Printer Status : Printing";
    case "80":
      return "Printer Status : Other error";
  }
  return status;
}

class ConnectionStatus extends ChangeNotifier {
  final _gtsplPlugin = Gtspl();
  bool _connected = false;

  bool get isConnected => _connected;
  Gtspl get GTSPL => _gtsplPlugin;

  Future<bool> connect(String ip, String port) async {
    _connected = await _gtsplPlugin.connect(ip, port);
    notifyListeners();
    return _connected;
  }

  Future<bool> disconnect() async {
    final res = await _gtsplPlugin.disconnect();
    if (res) {
      _connected = false;
      notifyListeners();
    }
    return res;
  }
}
