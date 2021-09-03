import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:onetwothree_sdk/onetwothree_sdk.dart';

void main() {
  const MethodChannel channel = MethodChannel('onetwothree_sdk');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await OneTwoThreeSDK.platformVersion, '42');
  });
}
