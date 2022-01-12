package com.example.flutter_second

import android.content.Context
import android.view.View
import android.widget.Button
import android.widget.TextView
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView

internal class NativeView(context: Context, id: Int, creationParams: Map<String?, Any?>?, flutterEngine: FlutterEngine) : PlatformView {
    private val textView: TextView = TextView(context)
    private val button: Button = Button(context)
    private val CHANNEL = "methodDat"
    override fun getView(): View {
        return button
    }

    override fun dispose() {}


    init {
        val text = "Android Button"

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
                .setMethodCallHandler { call, result ->
                    run {
                        when (call.method) {
                            "exitFlutter" -> {

                            }

                            else -> result.notImplemented()
                        }
                    }
                }
        button.text = text
        button.textSize = 52f

        button.setOnClickListener {
            MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
                    .invokeMethod("sendFromNative", "Text from Android")
        }
    }
}
