package com.example.flutter_second

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {
    private val CHANNEL = "methodDat"
    private  var mc:MethodChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
         mc = MethodChannel(flutterEngine.dartExecutor.binaryMessenger,CHANNEL)
        mc?.setMethodCallHandler { call, result ->
            run {
//                when(call.method){
//                    "sendFromNative" -> {
//                        result.success("From Android");
//                    }
//                    "moveToNaviteScreen" -> {
//                        val intent = Intent(this,ExampleActivity::class.java)
//                        startActivity(intent)
//                    }
//                }

            }
        }

        flutterEngine
                .platformViewsController
                .registry
                .registerViewFactory("native-view", NativeViewFactory(flutterEngine))
    }


}
