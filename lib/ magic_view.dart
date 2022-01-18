import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_second/controller.dart';

class NativeViewWidget extends StatefulWidget {
  const NativeViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  _NativeViewWidgetState createState() => _NativeViewWidgetState();
}

class _NativeViewWidgetState extends State<NativeViewWidget> {
  Map<String, dynamic> creationParams = <String, dynamic>{};
  String _text = 'Flutter screen';
  String _batteryLevel = 'Unknown counter number.';
  MethodChannel? _channel;

  static const platform = MethodChannel("dungChanel");

  _NativeViewWidgetState() {
    _channel = const MethodChannel('DatChanel');
    _channel?.setMethodCallHandler(_handleMethod);
    creationParams["viewType"] = "iOS Screen";
  }

  Future<void> _handleMethod(MethodCall call) async {
    String text;
    switch (call.method) {
      case 'sendFromNative':
        text = call.arguments;
        setState(() {
          _text = text;
        });
        break;

      default:
        break;
    }
  }

  Future<void> _getBatteryLevel() async {
    String countNumber;
    try {
      final int result = await platform.invokeMethod('getCountNumber');
      countNumber = 'Count number is: $result';
      print(countNumber);
    } on PlatformException catch (e) {
      countNumber = "Failed to get count number: '${e.message}'";
      print(countNumber);
    }

    setState(() {
      _batteryLevel = countNumber;
    });
  }

  moveToiOSScreen() {
    _channel?.invokeMethod("moveToNaviteScreen", "flutter");
  }

  @override
  Widget build(BuildContext context) {
    const String viewType = 'native-view';
    // const String viewType = 'native-ios';

    return Column(
      children: [
        Container(
          color: Colors.amber,
          height: 200,
          width: double.infinity,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_text,
                  style: const TextStyle(color: Colors.red, fontSize: 18)),
              ElevatedButton(
                  onPressed: () {
                    moveToiOSScreen();
                  },
                  child: const Text('Move to Native Screen',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))),
              ElevatedButton(
                child: const Text('Get Count Number'),
                onPressed: _getBatteryLevel,
              ),
              Text(
                _batteryLevel,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
          child: Platform.isIOS
              ? UiKitView(
                  viewType: viewType,
                  layoutDirection: TextDirection.ltr,
                  creationParams: creationParams,
                  creationParamsCodec: const StandardMessageCodec(),
                )
              : AndroidView(
                  viewType: viewType,
                  layoutDirection: TextDirection.ltr,
                  creationParams: creationParams,
                  creationParamsCodec: const StandardMessageCodec()),
        ),
      ],
    );
  }
}
