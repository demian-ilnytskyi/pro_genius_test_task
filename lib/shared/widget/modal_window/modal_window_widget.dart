import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_genius_test_task/shared/shared.dart';

class ModalWindowWidget extends StatefulWidget {
  const ModalWindowWidget({required this.child, super.key});
  final Widget child;

  @override
  State<ModalWindowWidget> createState() => _ModalWindowWidgetState();
}

class _ModalWindowWidgetState extends State<ModalWindowWidget> {
  double boxHeight = 300;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ModalWindowBloc, ModalWindowState>(
      listener: (context, state) {
        if (state.screenHeight == 0) {
          context.read<ModalWindowBloc>().add(
            ModalWindowEvent.setScreenScreenHeight(
              MediaQuery.sizeOf(context).height,
            ),
          );
        }
      },
      listenWhen: (previous, current) =>
          previous.screenHeight != current.screenHeight,
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          height: state.height,
          child: Column(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onVerticalDragUpdate: (details) => context
                    .read<ModalWindowBloc>()
                    .add(ModalWindowEvent.changeSize(details.delta.dy)),
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
              Expanded(child: widget.child),
            ],
          ),
        );
      },
    );
  }
}
