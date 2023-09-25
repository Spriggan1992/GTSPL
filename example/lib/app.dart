import 'package:flutter/material.dart';
import 'package:gtspl_example/connection_status.dart';
import 'package:gtspl_example/screen_main.dart';
import 'package:provider/provider.dart';

@immutable
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Пример GTSPL',
      home: ChangeNotifierProvider(
        create: (context) => ConnectionStatus(),
        child: const ScreenMain(),
      ),
    );
  }
}
