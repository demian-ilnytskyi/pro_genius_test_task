import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pro_genius_test_task/shared/bloc/modal_window/modal_window_bloc.dart';

class ModalWindowBlocProvider extends StatelessWidget {
  const ModalWindowBlocProvider({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => GetIt.I.get<ModalWindowBloc>(),
      child: child,
    );
  }
}
