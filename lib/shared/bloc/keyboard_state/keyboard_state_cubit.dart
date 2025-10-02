import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class KeyboardStateCubit extends Cubit<KeyboardState> {
  KeyboardStateCubit() : super(KeyboardState._canBeOpen);

  void closeKeyboard() {
    emit(KeyboardState._close);
  }

  void keyboardClosed() {
    emit(KeyboardState._canBeOpen);
  }
}

enum KeyboardState {
  _canBeOpen,
  _close;

  bool get canBeOpen => this == KeyboardState._canBeOpen;
  bool get needClose => this == KeyboardState._close;
}
