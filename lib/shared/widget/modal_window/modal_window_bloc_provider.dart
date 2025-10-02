import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pro_genius_test_task/shared/shared.dart';

class ModalWindowBlocProvider extends StatelessWidget {
  const ModalWindowBlocProvider({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => GetIt.I.get<ModalWindowBloc>(),
        ),
        BlocProvider(create: (context) => GetIt.I.get<KeyboardStateCubit>()),
      ],
      child: child,
    );
  }
}
