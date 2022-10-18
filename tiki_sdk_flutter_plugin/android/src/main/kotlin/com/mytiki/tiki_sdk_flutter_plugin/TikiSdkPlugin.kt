package com.mytiki.tiki_sdk_flutter_plugin

import android.content.Context
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

/** TikiSdkPluginTikiSdkPlugin */
class TikiSdkPlugin(private val apiKey: String, private val origin: String, context : Context? = null) : FlutterPlugin {

    private var flutterEngine: FlutterEngine? = null
    private var methodChannel: MethodChannel? = null
    private var caller: TikiSdkPluginCaller? = null
    
    companion object{
        const val channelId = "tiki_sdk_flutter"
    }
    
    init{
        if(context != null) {
            setupChannel(context)
        }
    }

    private fun setupChannel(context: Context){
        if(methodChannel == null){
            if(flutterEngine == null) flutterEngine = FlutterEngine(context)
            methodChannel = MethodChannel(flutterEngine!!.dartExecutor, channelId)
        }
        buildSdk()
    }

    private fun setupChannel(messenger: BinaryMessenger) {
        methodChannel = MethodChannel(messenger, channelId)
        buildSdk()
    }

    private fun buildSdk(){
        caller = TikiSdkPluginCaller(methodChannel!!)
        methodChannel!!.setMethodCallHandler(TikiSdkPluginHandler(caller!!))
        methodChannel!!.invokeMethod("build", mapOf(
            "apiKey" to apiKey,
            "origin" to origin
        ))
    }

    private fun teardownChannel() {
        methodChannel!!.setMethodCallHandler(null)
        methodChannel = null
        caller = null
    }
    
    override fun onAttachedToEngine(binding: FlutterPluginBinding) {
        setupChannel(binding.binaryMessenger)
    }

    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
        teardownChannel()
    }

}
