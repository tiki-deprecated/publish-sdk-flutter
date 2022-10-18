package com.mytiki.tiki_sdk_flutter_plugin

import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CompletableDeferred
import java.util.*


class TikiSdkPluginCaller(val methodChannel: MethodChannel) {
    var completables: MutableMap<String, CompletableDeferred<String>> = mutableMapOf()

    suspend fun assignOwnership(
        source: String,
        type: String,
        contains: List<String>,
        origin: String? = null
    ): String {
        val requestId = UUID.randomUUID().toString()
        methodChannel.invokeMethod(
            "assignOwnership", mapOf(
                "requestId" to requestId,
                "source" to source,
                "type" to type,
                "contains" to contains,
                "origin" to origin,
            )
        )
        val deferred = CompletableDeferred<String>()
        completables[requestId] = deferred
        return deferred.await()
    }

    suspend fun modifyConsent(
        source: String,
        destination: TikiSdkDestination,
        about: String? = null,
        reward: String? = null
    ): String {
        val requestId = UUID.randomUUID().toString()
        methodChannel.invokeMethod(
            "modifyConsent", mapOf(
                "requestId" to requestId,
                "source" to source,
                "destination" to destination.toJson(),
                "about" to about,
                "reward" to reward,
            )
        )
        val deferred = CompletableDeferred<String>()
        completables[requestId] = deferred
        return deferred.await()
    }

    suspend fun getConsent(
        source: String,
        origin: String? = null
    ): TikiSdkConsent {
        val requestId = UUID.randomUUID().toString()
        methodChannel.invokeMethod(
            "getConsent", mapOf(
                "requestId" to requestId,
                "source" to source,
                "origin" to origin,
            )
        )
        val deferred = CompletableDeferred<String>()
        completables[requestId] = deferred
        val jsonConsent = deferred.await()
        return TikiSdkConsent.fromJson(jsonConsent)
    }

    suspend fun applyConsent(
        source: String,
        destination: TikiSdkDestination,
        request: () -> Unit,
        onBlock: (value: String) -> Unit
    ) {
        val requestId = UUID.randomUUID().toString()
        methodChannel.invokeMethod(
            "applyConsent", mapOf(
                "requestId" to requestId,
                "source" to source,
                "destination" to destination.toJson(),
            )
        )
        try {
            val deferred = CompletableDeferred<String>()
            completables[requestId] = deferred
            deferred.await()
            request()
        } catch (e: Exception) {
            onBlock(e.message ?: "no consent")
        }
    }
}