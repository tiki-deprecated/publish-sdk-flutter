package com.mytiki.tiki_sdk_flutter_plugin

import org.json.JSONArray
import org.json.JSONObject

data class TikiSdkDestination(val uses: List<String>, val paths: List<String>) {
    companion object {
        fun fromJson(jsonString: String): TikiSdkDestination {
            val jsonObject = JSONObject(jsonString)
            val usesArr: JSONArray = jsonObject.getJSONArray("uses")
            val uses: MutableList<String> =
                MutableList(usesArr.length()) { i -> usesArr.getString(i) }
            val pathsArr = jsonObject.getJSONArray("paths")
            val paths = MutableList<String>(pathsArr.length()) { i -> pathsArr.getString(i) }
            return TikiSdkDestination(
                uses,
                paths
            )
        }
    }

    fun toJson(): String {
        val jsonObject = JSONObject()
        jsonObject.put("uses", JSONArray(uses))
        jsonObject.put("paths", JSONArray(paths))
        return jsonObject.toString()
    }
}
