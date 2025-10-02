import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_genius_test_task/l10n/l10n.dart';
import 'package:pro_genius_test_task/shared/shared.dart';

class ModalWindowWidget extends StatelessWidget {
  const ModalWindowWidget({required this.url, super.key});
  final String url;

  @override
  Widget build(BuildContext context) {
    // it not rebuild this widget with change heigh
    // it no need and improve performence
    final webView = BlocBuilder<KeyboardStateCubit, KeyboardState>(
      builder: (context, state) => ModalWindowContentWidget(
        url: url,
        closeKeyboard: state.needClose,
        closeKeyboardEvent: () =>
            context.read<KeyboardStateCubit>().keyboardClosed(),
      ),
    );
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
          current.maxWebViewHeight != previous.maxWebViewHeight ||
          current.dragBarHeight != previous.dragBarHeight,
      builder: (context, state) => ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: state.maxWebViewHeight + state.dragBarHeight,
          minHeight: state.dragBarHeight,
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
                onVerticalDragStart: (_) =>
                    context.read<KeyboardStateCubit>().closeKeyboard(),
                onVerticalDragEnd: (_) => context.read<ModalWindowBloc>().add(
                  const ModalWindowEvent.setHeighState(),
                ),
                child: ColoredBox(
                  color: Colors.red,
                  child: SizedBox(
                    height: state.dragBarHeight,
                    child: Row(
                      children: [
                        const Expanded(child: SizedBox.shrink()),
                        Text(
                          context.l10n.dragHere,
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: IconButton(
                                onPressed: () {
                                  context
                                      .read<KeyboardStateCubit>()
                                      .closeKeyboard();
                                  final bloc = context.read<ModalWindowBloc>();
                                  if (bloc.state.showCloseIcon) {
                                    if (context.canPop()) {
                                      context.pop();
                                    }
                                  } else {
                                    bloc.add(const ModalWindowEvent.hide());
                                  }
                                },
                                icon:
                                    BlocSelector<
                                      ModalWindowBloc,
                                      ModalWindowState,
                                      bool
                                    >(
                                      selector: (state) => state.showCloseIcon,
                                      builder: (context, showCloseIcon) => Icon(
                                        showCloseIcon
                                            ? Icons.close
                                            : Icons
                                                  .keyboard_arrow_down_outlined,
                                        size: 24,
                                      ),
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              BlocSelector<
                ModalWindowBloc,
                ModalWindowState,
                ({double height, int animationTime})
              >(
                selector: (state) =>
                    (height: state.height, animationTime: state.animationTime),
                builder: (context, state) => Flexible(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: state.animationTime),
                    curve: Curves.easeOut,
                    height: state.height,
                    child: webView,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
