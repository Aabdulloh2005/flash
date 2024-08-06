package com.example.homewrok_search

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.hardware.camera2.CameraManager
import android.content.Context

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.flashlight/flashlight"
    private var isFlashOn = false

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "toggleFlashlight") {
                isFlashOn = !isFlashOn
                toggleFlashlight(isFlashOn)
                result.success(isFlashOn)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun toggleFlashlight(status: Boolean) {
        val cameraManager = getSystemService(Context.CAMERA_SERVICE) as CameraManager
        val cameraId = cameraManager.cameraIdList[0]
        cameraManager.setTorchMode(cameraId, status)
    }
}
