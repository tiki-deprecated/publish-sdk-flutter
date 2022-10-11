package com.mytiki.tiki_sdk_flutter
import org.json.JSONArray
import org.json.JSONObject

data class TikiSdkDestination(val uses: List<String>, val paths: List<String>){
    fun toJson() : String{
        val jsonObject = JSONObject()
        jsonObject.put("uses", JSONArray(uses));
        jsonObject.put("paths", JSONArray(paths));
        return jsonObject.toString()
    }
}
