package com.mytiki.tiki_sdk_flutter_plugin

import android.content.Context
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

/**
 * Tiki sdk plugin
 *
 * @property apiKey
 * @property origin
 * @constructor
 *
 * @param context
 */
class TikiSdkFlutterChannel(
    var apiKey: String? = null,
    var origin: String? = null,
    context: Context? = null
) : FlutterPlugin, MethodChannel.MethodCallHandler  {

    var caller: TikiSdkPluginCaller? = null

    private var flutterEngine: FlutterEngine? = null
    private var methodChannel: MethodChannel? = null

    companion object {
        const val channelId = "tiki_sdk_flutter"
    }

    init {
        if (context != null) {
            setupChannel(context)
        }
    }

    private fun setupChannel(context: Context) {
        if (methodChannel == null) {
            if (flutterEngine == null) flutterEngine = FlutterEngine(context)
            methodChannel = MethodChannel(flutterEngine!!.dartExecutor, channelId)
        }
        buildSdk()
    }

    private fun setupChannel(messenger: BinaryMessenger) {
        methodChannel = MethodChannel(messenger, channelId)
        buildSdk()
    }

    private fun buildSdk() {
        caller = TikiSdkPluginCaller(methodChannel!!)
        methodChannel!!.setMethodCallHandler(TikiSdkPluginHandler(caller!!))
        methodChannel!!.invokeMethod(
            "build", mapOf(
                "apiKey" to apiKey,
                "origin" to origin
            )
        )
    }

    private fun teardownChannel() {
        methodChannel!!.setMethodCallHandler(null)
        methodChannel = null
        caller = null
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        val requestId = call.argument<String>("requestId")
        val response = call.argument<String?>("response")
        if (requestId == null) result.error("-1", "missing requestId argument", call.arguments)
        when (call.method) {
            "success" -> {
                caller.completables[requestId]?.complete(response)
            }
            "error" -> {
                caller.completables[requestId]?.completeExceptionally(Exception(response))
            }
            else -> result.notImplemented()
        }
        caller.completables.remove(requestId)
    }

    override fun onAttachedToEngine(binding: FlutterPluginBinding) {
        setupChannel(binding.binaryMessenger)
    }

    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
        teardownChannel()
    }

}
