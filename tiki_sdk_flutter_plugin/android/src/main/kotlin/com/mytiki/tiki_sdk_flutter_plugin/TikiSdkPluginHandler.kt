package com.mytiki.tiki_sdk_flutter_plugin

import androidx.annotation.NonNull
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.lang.Exception

class TikiSdkPluginHandler(private val helper: TikiSdkPluginCaller) : MethodChannel.MethodCallHandler {

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        val requestId = call.argument<String>("requestId")
        val value = call.argument<String>("value")
        if(requestId == null) result.error("-1", "missing requestId argument", call.arguments)
        if(value == null) result.error("-1", "missing value argument", call.arguments)
        when (call.method) {
            "success" -> {
                helper.completables[requestId]?.complete(value!!)
            }
            "error" -> {
                helper.completables[requestId]?.completeExceptionally(Exception(value))
            }
            else -> result.notImplemented()
        }
        helper.completables.remove(requestId)
    }

}


