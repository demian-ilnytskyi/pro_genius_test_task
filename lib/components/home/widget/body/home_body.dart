import 'package:flutter/material.dart';
import 'package:pro_genius_test_task/components/home/widget/modal_window_content_widget.dart';
import 'package:pro_genius_test_task/l10n/l10n.dart';
import 'package:pro_genius_test_task/shared/widget/dialog_widget_helper.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () => context.dialog.showModalWndow(
          child: const ModalWindowContentWidget(),
        ),
        child: Text(context.l10n.openModalWindow),
      ),
    );
  }
}
