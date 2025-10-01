import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_genius_test_task/l10n/l10n.dart';
import 'package:pro_genius_test_task/shared/constants/route_constants.dart';

class ErrorBodyWidget extends StatelessWidget {
  const ErrorBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => context.goNamed(KRoute.home.name),
        child: Text(context.l10n.errorMessage),
      ),
    );
  }
}
