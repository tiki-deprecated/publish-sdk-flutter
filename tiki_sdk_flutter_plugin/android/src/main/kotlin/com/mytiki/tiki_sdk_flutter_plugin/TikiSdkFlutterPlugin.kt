package com.mytiki.tiki_sdk_flutter_plugin

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

/** TikiSdkFlutterPlugin */
class TikiSdkFlutterPlugin : FlutterPlugin, MethodCallHandler {
    var channel: MethodChannel? = null
    val requestCallbacks: MutableMap<String, () -> Unit> = mutableMapOf()
    val blockCallbacks: MutableMap<String, (value: String) -> Unit> = mutableMapOf()

    private fun callRequest(id: String){
        blockCallbacks.remove(id)
        requestCallbacks[id]!!()
    }

    private fun blockRequest(id: String, value: String){
        requestCallbacks.remove(id)
        blockCallbacks[id]!!(value)
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "tiki_sdk_flutter")
        channel!!.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        when (call.method) {
            "callRequest" -> {
                val requestId = call.argument<String>("requestId")
                if(requestId == null) result.error("-1", "missing requestId argument", call.arguments)
                callRequest(requestId!!)
            }
            "blockRequest" -> {
                val requestId = call.argument<String>("requestId")
                val value = call.argument<String>("value")
                if(requestId == null) result.error("-1", "missing requestId argument", call.arguments)
                if(value == null) result.error("-1", "missing value argument", call.arguments)
                blockRequest(requestId!!, value!!)
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel?.setMethodCallHandler(null)
    }
}
