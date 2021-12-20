import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:weather_app/core/core.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WeatherMapWebView extends StatefulWidget {
  const WeatherMapWebView({Key? key}) : super(key: key);
  static const routeName = 'weatherMap';

  @override
  State<WeatherMapWebView> createState() => _WeatherMapWebViewState();
}

class _WeatherMapWebViewState extends State<WeatherMapWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: AppConstants.webViewUrl,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ));
  }
}
