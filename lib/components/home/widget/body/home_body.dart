import 'package:flutter/material.dart';
import 'package:pro_genius_test_task/l10n/l10n.dart';
import 'package:pro_genius_test_task/shared/widget/dialog_widget_helper.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () =>
            context.dialog.showModalWndow('https://www.proggenius.com/'),
        child: Text(context.l10n.openModalWindow),
      ),
    );
  }
}
