// import 'package:flutter_test/flutter_test.dart';
// import 'package:gtspl/gtspl.dart';
// import 'package:gtspl/gtspl_platform_interface.dart';
// import 'package:gtspl/gtspl_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockGtsplPlatform
//     with MockPlatformInterfaceMixin
//     implements GtsplPlatform {
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

// void main() {
//   final GtsplPlatform initialPlatform = GtsplPlatform.instance;

//   test('$MethodChannelGtspl is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelGtspl>());
//   });

//   test('getPlatformVersion', () async {
//     Gtspl gtsplPlugin = Gtspl();
//     MockGtsplPlatform fakePlatform = MockGtsplPlatform();
//     GtsplPlatform.instance = fakePlatform;

//     expect(await gtsplPlugin.getPlatformVersion(), '42');
//   });
// }
