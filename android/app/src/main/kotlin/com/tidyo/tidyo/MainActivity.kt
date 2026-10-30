package com.tidyo.tidyo

import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.SystemClock
import android.provider.Settings
import android.view.View
import android.view.ViewTreeObserver
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.tidyo.tidyo/app_settings"
    private val splashHoldMs = 1000L
    private var startTime = 0L

    override fun onCreate(savedInstanceState: Bundle?) {
        startTime = SystemClock.uptimeMillis()
        super.onCreate(savedInstanceState)

        if (Build.VERSION.SDK_INT >= 31) {
            val content: View = findViewById(android.R.id.content)
            content.viewTreeObserver.addOnPreDrawListener(
                object : ViewTreeObserver.OnPreDrawListener {
                    override fun onPreDraw(): Boolean {
                        val ready = SystemClock.uptimeMillis() - startTime >= splashHoldMs
                        if (ready) {
                            content.viewTreeObserver.removeOnPreDrawListener(this)
                        } else {
                            content.postInvalidateDelayed(16)
                        }
                        return ready
                    }
                }
            )
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "openAppInfo") {
                val packageName = call.argument<String>("package")
                if (packageName != null) {
                    try {
                        val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS).apply {
                            data = Uri.fromParts("package", packageName, null)
                            flags = Intent.FLAG_ACTIVITY_NEW_TASK
                        }
                        startActivity(intent)
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("ERROR", e.message, null)
                    }
                } else {
                    result.error("INVALID_ARG", "Package name is null", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
