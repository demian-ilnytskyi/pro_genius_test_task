import 'package:flutter/material.dart';
import 'package:pro_genius_test_task/components/error/widget/body/error_body_widget.dart';
import 'package:pro_genius_test_task/l10n/l10n.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text(context.l10n.errorTitle)),
          body: const ErrorBodyWidget(),
        ),
      ),
    );
  }
}
