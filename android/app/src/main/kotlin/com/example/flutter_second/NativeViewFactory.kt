package com.example.flutter_second

import android.content.Context
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class NativeViewFactory(val flutterEngine: FlutterEngine) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {


    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String?, Any?>?

        return NativeView(context, viewId, creationParams,flutterEngine)
    }

}
