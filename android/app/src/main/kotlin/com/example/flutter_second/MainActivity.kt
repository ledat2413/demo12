package com.example.flutter_second

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {
    private val CHANNEL = "methodDat"
    private  var mc:MethodChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
         mc = MethodChannel(flutterEngine.dartExecutor.binaryMessenger,CHANNEL)
//        mc?.setMethodCallHandler { call, result ->
//            run {
//
////                if (call.method.equals("sendFromNative")) {
////                    result.success("From Android");
////                }
//            }
//        }

        flutterEngine
                .platformViewsController
                .registry
                .registerViewFactory("native-view", NativeViewFactory(flutterEngine))
    }


}
