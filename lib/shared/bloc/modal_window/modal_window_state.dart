part of 'modal_window_bloc.dart';

@freezed
sealed class ModalWindowState with _$ModalWindowState {
  const factory ModalWindowState({
    required double height,
    required double minWindowHeight,
    required double maxWindowHeight,
    double? screenHeight,
  }) = _ModalWindowState;
}
