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

  MethodChannel? _channel;

  _NativeViewWidgetState() {
    _channel = const MethodChannel('methodDat');
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

  @override
  Widget build(BuildContext context) {
    const String viewType = 'native-ios-view';
    // const String viewType = 'native-ios';

    return Column(
      children: [
        Container(
          color: Colors.amber,
          height: 200,
          width: double.infinity,
          alignment: Alignment.center,
          child: Text(_text,
              style: const TextStyle(color: Colors.red, fontSize: 18)),
        ),
        Expanded(
          child: UiKitView(
            viewType: viewType,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
          ),
        ),
      ],
    );
  }
}
