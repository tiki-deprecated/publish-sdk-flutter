package com.mytiki.tiki_sdk_flutter_plugin

interface L0StorageInterface {
    fun read(path: String) : ByteArray?
    fun write(path: String, obj: ByteArray)
    fun getAll(address: String) : Map<String, ByteArray>
}