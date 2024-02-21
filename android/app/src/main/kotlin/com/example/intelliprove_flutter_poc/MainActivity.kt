package com.example.intelliprove_flutter_poc

import com.intelliprove.webview.IntelliWebViewActivity
import com.intelliprove.webview.IntelliWebViewDelegate
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity(private var webViewChannel: MethodChannel? = null): FlutterActivity(), IntelliWebViewDelegate {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        webViewChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.intelliprove/webview"
        )

        webViewChannel?.setMethodCallHandler { call, result ->
            if (call.method == "openWebview") {
                val args = call.arguments as? Map<*, *>
                val urlString = args?.get("url") as? String
                urlString?.let {
                    openWebView(it)
                }
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun openWebView(urlString: String) {
        IntelliWebViewActivity.start(this, urlString, this)
    }

    override fun didReceivePostMessage(postMessage: String) {
        runOnUiThread {
            webViewChannel?.invokeMethod("didReceivePostMessage", postMessage)
        }
    }
}
