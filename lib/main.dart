import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IntelliProve Flutter POC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'IntelliProve Flutter POC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('com.intelliprove/webview');

  @override
  void initState() {
    super.initState();
    // Add the Native callback handler during init
    platform.setMethodCallHandler(handleNativeCallback);
  }

  // Bridge from Flutter to Native for presenting IntelliWebView
  void openWebView(String url) async {
    try {
      await platform.invokeMethod('openWebview', {'url': url});
    } on PlatformException catch (e) {
      print("Failed to open webview: ${e.message}");
    }
  }

  // Callback from Native to Flutter with postMessage API body
  Future<void> handleNativeCallback(MethodCall call) async {
    if (call.method == 'didReceivePostMessage') {
      String postMessage = call.arguments;
      print("Flutter PostMessage Full Body: ${postMessage}");

      // postMessage is received as JSON string, so we need to parse it
      Map<String, dynamic> postData = jsonDecode(postMessage);
      String stage = postData['stage'];
      print("Flutter PostMessage Stage: $stage");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Tap the button to open the browser',
            ),
            ElevatedButton(
              onPressed: () => openWebView(
                  'https://plugin-streaming-dev.intelliprove.com/?action_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImVtYWlsIjoiIiwiY3VzdG9tZXIiOiJOZWJ1bGFlIHRlc3RpbmciLCJncm91cCI6ImFkbWluIiwibWF4X21lYXN1cmVtZW50X2NvdW50IjoxMDAwfSwibWV0YSI6e30sImV4cCI6MTcxNTA3NDIyMn0.kQvGQD_8wFzmLjgFMuft_i3nWjAxSKWx5oI_FBFEYXI'),
              child: Text('Open WebView'),
            ),
          ],
        ),
      ),
    );
  }
}
