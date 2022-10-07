package com.mytiki.tiki_sdk_android

import com.mytiki.tiki_sdk_flutter.TikiSdkFlutterPlugin

class TikiSdk(private val flutterPlugin: TikiSdkFlutterPlugin = TikiSdkFlutterPlugin()) {

    var apiKey: String? = null
    var l0storage: L0StorageInterface? = null

    fun buildSdk() {
        if(l0storage == null && apiKey == null){
            throw Exception("Set apiKey or l0storage for chain backup")
        }
        flutterPlugin.channel.invokeMethod(
            "buildSdk", mapOf(
                "apiKey" to apiKey
            )
        )
    }

    fun assignOwnership(
        source: String,
        type: String,
        contains: List<String>,
        origin: String?
    ) {
        flutterPlugin.channel.invokeMethod(
            "assignOwnership", mapOf(
                "source" to source,
                "type" to type,
                "contains" to contains,
                "origin" to origin,
            )
        )
    }

    fun getConsent(source: String, origin: String?) {
        flutterPlugin.channel.invokeMethod(
            "getConsent", mapOf(
                "source" to source,
                "origin" to origin
            )
        )
    }

    fun modifyConsent(
        ownershipId: String,
        destination: TikiSdkDestination,
        about: String?,
        reward: String?
    ) {
        flutterPlugin.channel.invokeMethod(
            "modifyConsent", mapOf(
                "ownershipId" to ownershipId,
                "destination" to destination.toJson(),
                "about" to about,
                "reward" to reward,
            )
        )
    }

    fun applyConsent(
        source: String,
        destination: TikiSdkDestination,
        requestId: String,
        request: () -> Unit,
        onBlock: (value: String) -> Unit
    ) {
        flutterPlugin.channel.invokeMethod(
            "applyConsent", mapOf(
                "source" to source,
                "destination" to destination,
                "requestId" to requestId,
            )
        )
    }
}