import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_genius_test_task/shared/shared.dart';

class ModalWindowWidget extends StatelessWidget {
  const ModalWindowWidget({required this.url, super.key});
  final String url;

  @override
  Widget build(BuildContext context) {
    // it not rebuild this widget with change heigh
    // it no need and improve performence
    final webView = ModalWindowContentWidget(url: url);
    return BlocConsumer<ModalWindowBloc, ModalWindowState>(
      listener: (context, state) {
        if (state.screenHeight == 0) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            final height = MediaQuery.sizeOf(context).height;
            // MediaQuery.paddingOf(context); not worked it always return 0
            final paddingTop = MediaQueryData.fromView(
              View.of(context),
            ).padding.top;
            context.read<ModalWindowBloc>().add(
              ModalWindowEvent.setScreenScreenHeight(
                screenHeight: height,
                topPadding: paddingTop,
              ),
            );
          });
        }
      },
      listenWhen: (previous, current) =>
          previous.screenHeight != current.screenHeight,
      buildWhen: (previous, current) =>
          current.maxWindowHeight != previous.maxWindowHeight ||
          current.minWindowHeight != previous.minWindowHeight,
      builder: (context, state) => ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: state.maxWindowHeight,
          minHeight: state.minWindowHeight,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom, // Keyboard Padding
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onVerticalDragUpdate: (details) => context
                    .read<ModalWindowBloc>()
                    .add(ModalWindowEvent.changeSize(details.delta.dy)),
                onVerticalDragStart: (_) {
                  FocusScope.of(context).unfocus(); // hide keyboard
                },
                onVerticalDragEnd: (_) => context.read<ModalWindowBloc>().add(
                  const ModalWindowEvent.setHeighState(),
                ),
                child: Container(
                  height: state.minWindowHeight,
                  color: Colors.red,
                  alignment: Alignment.center,
                  child: const Text(
                    'Drag Here',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              BlocSelector<ModalWindowBloc, ModalWindowState, double>(
                selector: (state) => state.height,
                builder: (context, height) => AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeOut,
                  height: height,
                  child: webView,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
