import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let webviewChannel = FlutterMethodChannel(
            name: "com.intelliprove/openWebview",
            binaryMessenger: controller.binaryMessenger
        )

        webviewChannel.setMethodCallHandler({ [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            if call.method == "openWebview" {
                if let args = call.arguments as? [String: Any],
                   let urlString = args["url"] as? String {
                    self?.openWebView(urlString: urlString)
                }
                result(nil)
            } else {
                result(FlutterMethodNotImplemented)
            }
        })

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func openWebView(urlString: String) {
        let webViewController = IntelliWebViewFactory.newWebView(urlString: urlString)
        webViewController.modalPresentationStyle = .fullScreen
        window?.rootViewController?.present(webViewController, animated: true)
    }
}
