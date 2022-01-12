import 'package:flutter/services.dart';

class MagicViewController {
  MethodChannel? _channel;

  MagicViewController() {
    _channel = const MethodChannel('methodDat');
    _channel?.setMethodCallHandler(_handleMethod);
  }
  
  Future<String?> _handleMethod(MethodCall call) async {
    String? text;
    switch (call.method) {
      case 'sendFromNative':
        text = call.arguments as String;
        break;
      default:
        break;
    }
    return text;
  }

  Future<void> receiveFromFlutter(String text) async {
    try {
      final String result = await _channel?.invokeMethod('getText', text);
      print("Result from native: $result");
    } on PlatformException catch (e) {
      print("Error from native: $e.message");
    }
  }
}
