import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ModalWindowContentWidget extends StatefulWidget {
  const ModalWindowContentWidget({
    required this.url,
    required this.closeKeyboard,
    required this.closeKeyboardEvent,
    super.key,
  });
  final String url;
  final bool closeKeyboard;
  final void Function() closeKeyboardEvent;

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
  void didUpdateWidget(covariant ModalWindowContentWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.closeKeyboard && widget.closeKeyboard) {
      controller.runJavaScript('document.activeElement.blur();');
      widget.closeKeyboardEvent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}
