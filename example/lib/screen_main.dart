import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gtspl_example/connection_status.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

@immutable
class ScreenMain extends StatefulWidget {
  const ScreenMain({Key? key}) : super(key: key);

  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  final ipController = TextEditingController();
  final portController = TextEditingController();

  Future<File> _getFileFromAssets(String asset) async {
    final byteData = await rootBundle.load(asset);
    final buffer = byteData.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    final parts = asset.split(RegExp('/'));
    var filePath = '$tempPath/${parts.last}';
    return File(filePath).writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }

  Future<void> handleConnect() async {
    final res = await Provider.of<ConnectionStatus>(context, listen: false)
        .connect(ipController.text, portController.text);
    Fluttertoast.showToast(
      msg: res ? "Success" : "Fail",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: res ? Colors.white : Colors.red,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  Future<void> handleDisconnect() async {
    final res = await Provider.of<ConnectionStatus>(context, listen: false)
        .disconnect();
    Fluttertoast.showToast(
      msg: res ? "Success" : "Fail",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: res ? Colors.white : Colors.red,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  Future<void> handleGetStatus() async {
    final res = await Provider.of<ConnectionStatus>(context, listen: false)
        .GTSPL
        .status();
    Fluttertoast.showToast(
      msg: statusToString(res),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  Future<void> handleUploadFont() async {
    final gspl = Provider.of<ConnectionStatus>(context, listen: false).GTSPL;
    final fontFile = await _getFileFromAssets('assets/fonts/Arial.ttf');
    final size = await fontFile.length();
    final res = await gspl.sendCommandAndFile(
        'DOWNLOAD F,"Arial.ttf",$size,', fontFile.path);
    Fluttertoast.showToast(
      msg: res ? "Success" : "Fail",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: res ? Colors.white : Colors.red,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  Future<void> handleTestFont() async {
    final gspl = Provider.of<ConnectionStatus>(context, listen: false).GTSPL;
    var template = (await rootBundle.loadString('assets/templates/rus.zpl'));
    final res = await gspl.sendCommand(template);
    Fluttertoast.showToast(
      msg: res ? "Success" : "Fail",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: res ? Colors.white : Colors.red,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  Future<void> handleTestZPL() async {
    final gspl = Provider.of<ConnectionStatus>(context, listen: false).GTSPL;
    var template = (await rootBundle.loadString('assets/templates/zpl.zpl'));
    final res = await gspl.sendCommand(template);
    Fluttertoast.showToast(
      msg: res ? "Success" : "Fail",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: res ? Colors.white : Colors.red,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme primaryTextTheme = Theme.of(context).primaryTextTheme;
    final decoration = InputDecoration(
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      labelStyle: primaryTextTheme.bodyLarge?.copyWith(
        color: Colors.black,
      ),
    );
    final isConnected = context.watch<ConnectionStatus>().isConnected;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Пример работы с GTSPL'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: ipController,
                decoration: decoration.copyWith(
                  label: const Text('IP адрес принтера'),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: portController,
                decoration: decoration.copyWith(
                  label: const Text('Порт принтера'),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: isConnected ? null : handleConnect,
                child: const Text('Подключить'),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: isConnected ? handleDisconnect : null,
                child: const Text('Отключить'),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: isConnected ? handleGetStatus : null,
                child: const Text('Статус принтера'),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: isConnected ? handleUploadFont : null,
                child: const Text('Загрузить шрифт'),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: isConnected ? handleTestFont : null,
                child: const Text('Проверить шрифт'),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: isConnected ? handleTestZPL : null,
                child: const Text('Тест ZPL'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
