package com.ihadis.quran

import android.content.Context
import android.os.Bundle
import android.util.Log
import com.ryanheise.audioservice.AudioServiceActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

const val LEGACY_CHANNEL = "com.ihadis.quran/legacy"
const val FETCH_BOOKMARKS = "fetch_bookmarks"

class MainActivity : AudioServiceActivity(), MethodChannel.MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        context = this
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Initialize the MethodChannel
        channel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, LEGACY_CHANNEL
        )
        channel.setMethodCallHandler(this)
    }

    private suspend fun fetchBookmarks(): String {
        return withContext(Dispatchers.IO) {
            try {
                val sharedPreferences =
                    context.getSharedPreferences("bookmark", Context.MODE_PRIVATE)
                sharedPreferences.getString("bookmark", "") ?: ""
            } catch (e: Exception) {
                Log.e(TAG, "fetchBookmarks: failed -> ${e.localizedMessage}", e)
                ""
            }
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        CoroutineScope(Dispatchers.Main).launch {
            when (call.method) {
                FETCH_BOOKMARKS -> {
                    val bookmarks = fetchBookmarks()
                    result.success(bookmarks)
                }
                else -> result.notImplemented()
            }
        }
    }

    companion object {
        private const val TAG = "MainActivity"
    }
}