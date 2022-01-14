package com.example.flutter_second

import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {
    private val CHANNEL = "dungChanel"
    private  var mc:MethodChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)


        flutterEngine
                .platformViewsController
                .registry
                .registerViewFactory("native-view", NativeViewFactory(flutterEngine))

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            run {
                when(call.method){
                    "getBatteryLevel" -> {
                        val batteryLevel = this.getBatteryLevel();
                        if (batteryLevel != -1) {
                            result.success(batteryLevel);
                        } else {
                            result.error("UNAVAILABLE", "Battery level not available.", null);
                        }
                    }
                }

            }
        }
    }
     private fun getBatteryLevel(): Int {
        var batteryLevel = -1
        batteryLevel = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager: BatteryManager = getSystemService(BATTERY_SERVICE) as BatteryManager
            batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent: Intent? = ContextWrapper(getApplicationContext()).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            (intent?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)?.times(100) ?: 0) / intent?.getIntExtra(BatteryManager.EXTRA_SCALE, -1)!!
        }
        return batteryLevel
    }

}
