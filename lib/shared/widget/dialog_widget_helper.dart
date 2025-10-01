import 'package:flutter/material.dart';
import 'package:pro_genius_test_task/shared/widget/modal_window/modal_window_bloc_provider.dart';
import 'package:pro_genius_test_task/shared/widget/modal_window/modal_window_widget.dart';

// import 'package:pro_genius_test_task/shared/widget/test.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
extension DiaglogExtention on BuildContext {
  // ignore: library_private_types_in_public_api
  _DialogsWidget get dialog => _DialogsWidget.of(this);
}

class _DialogsWidget {
  _DialogsWidget.of(this.context);
  final BuildContext context;

  void showModalWndow({required Widget child}) {
    showModalBottomSheet<void>(
      context: context,
      enableDrag: false,
      isScrollControlled: true,
      builder: (context) {
        return ModalWindowBlocProvider(child: ModalWindowWidget(child: child));
      },
    );
  }
}
