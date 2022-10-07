package com.mytiki.tiki_sdk_android

interface L0StorageInterface {
    fun read(path: String) : ByteArray?
    fun write(path: String, obj: ByteArray)
    fun getAll(address: String) : Map<String, ByteArray>
}