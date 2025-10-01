import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ModalWindowContentWidget extends StatefulWidget {
  const ModalWindowContentWidget({required this.url, super.key});
  final String url;

  @override
  State<ModalWindowContentWidget> createState() =>
      _ModalWindowContentWidgetState();
}

class _ModalWindowContentWidgetState extends State<ModalWindowContentWidget> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}
