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

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getAll" -> {
                val all: Map<String,ByteArray> = l0Storage!!.getAll(call.arguments["address"])
                result(all)
            }
            "read" -> {
                val obj: ByteArray? = l0Storage!!.read(call.arguments["path"])
                result(obj)
            }
            "write" -> {
                l0Storage!!.write(call.arguments["path"], call.arguments["obj"])
            }
            "callRequest" -> callRequest(call.arguments["requestId"])
            "blockRequest" -> blockRequest(call.arguments["requestId"], call.arguments["value"])
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
