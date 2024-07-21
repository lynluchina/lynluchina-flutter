import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:real_estate/theme/color.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _controller;
  bool _isLoading = true;
  String _pageTitle = '';
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (String url) {
          setState(() {
            _isLoading = true;
            _errorMessage = '';
          });
        },
        onPageFinished: (String url) {
          _controller.getTitle().then((title) {
            setState(() {
              _pageTitle = title ?? '';
              _isLoading = false;
            });
          });
        },
        onWebResourceError: (WebResourceError error) {
          // Ignore ERR_BLOCKED_BY_ORB errors
          if (error.errorCode != -30 && error.description != 'net::ERR_BLOCKED_BY_ORB') {
            setState(() {
              _errorMessage = 'Failed to load page: ${error.description}';
              _isLoading = false;
            });
          }
        },
      ))
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(_pageTitle),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColor.primary),
              ),
            ),
          if (_errorMessage.isNotEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}