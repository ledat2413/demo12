package com.example.flutter_second

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import androidx.core.content.ContextCompat.startActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import kotlinx.android.synthetic.main.android_view.view.*

class NativeView(context: Context, id: Int, creationParams: Map<String?, Any?>?, flutterEngine: FlutterEngine) : PlatformView {
    private val CHANNEL = "methodDat"
    private var view:View? = null

    override fun getView(): View? {

        return view
    }

    override fun dispose() {}


    init {

        val bundle = Bundle()
        view = LayoutInflater.from(context).inflate(R.layout.android_view, null)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
                .setMethodCallHandler { call, result ->
                    run {
                        when (call.method) {
                            "exitFlutter" -> {

                            }
                            "moveToNaviteScreen" -> {
                                val intent = Intent(context, ExampleActivity::class.java)
                                intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                                startActivity(context, intent, bundle)

                                val text = call.arguments
                                view?.button?.text = text.toString()
                            }

                            else -> result.notImplemented()
                        }
                    }
                }

        view?.button?.setOnClickListener {
                        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
                    .invokeMethod("sendFromNative", "Text from Android")
        }

    }
}
