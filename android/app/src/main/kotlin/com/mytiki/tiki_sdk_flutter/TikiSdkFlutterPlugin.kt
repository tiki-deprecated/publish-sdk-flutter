package com.mytiki.tiki_sdk_flutter

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

/** TikiSdkFlutterPlugin */
class TikiSdkFlutterPlugin : FlutterPlugin, MethodCallHandler {
    lateinit var channel: MethodChannel
    var l0Storage: L0StorageInterface? = null;
    val requestCallbacks: MutableMap<String, () -> Unit> = mutableMapOf<String, () -> Unit>()
    val blockCallbacks: MutableMap<String, (value: String) -> Unit> = mutableMapOf<String, (value: String) -> Unit>()

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
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        when (call.method) {
            "getAll" -> {
                val address = call.argument<String>("address")
                if(address == null) result.error("-1", "missing address argument", call.arguments)
                val all: Map<String,ByteArray> = l0Storage!!.getAll(address!!)
                result.success(all)
            }
            "read" -> {
                val path = call.argument<String>("path")
                if(path == null) result.error("-1", "missing path argument", call.arguments)
                val obj: ByteArray? = l0Storage!!.read(path!!)
                result.success(obj)
            }
            "write" -> {
                val path = call.argument<String>("path")
                val obj = call.argument<ByteArray>("obj")
                if(path == null) result.error("-1", "missing path argument", call.arguments)
                if(obj == null) result.error("-1", "missing obj argument", call.arguments)
                l0Storage!!.write(path!!, obj!!)
            }
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
        channel.setMethodCallHandler(null)
    }
}
